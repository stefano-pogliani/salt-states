import imp
import os
import shutil
import tempfile

import pytest

make = imp.load_source('make', 'states/_states/builders/make.py')


@pytest.fixture()
def test_dir(request):
  test_path = tempfile.mkdtemp()
  configure = os.path.join(test_path, 'configure')
  with open(configure, 'w') as f:
    f.write('')

  def cleanup():
    """Delete temporary fixture."""
    shutil.rmtree(test_path)

  request.addfinalizer(cleanup)
  return test_path


@pytest.fixture()
def salt_dict_fails():
  make.__salt__ = { 'cmd.retcode': lambda *args, **kwargs: 2 }

@pytest.fixture()
def salt_dict_success():
  make.__salt__ = { 'cmd.retcode': lambda *args, **kwargs: 0 }


@pytest.fixture()
def salt_test_opts():
  make.__opts__ = { 'test': True }


@pytest.fixture()
def salt_opts():
  make.__opts__ = { 'test': False }


def assert_salt_response(state_result, comment, changes=None, name='/tmp',
                         result=True):
  assert state_result == {
    'name':    name,
    'changes': changes,
    'result':  result,
    'comment': comment
  }


class TestConfigure(object):
  def test_validates_path(self):
    result = make.configure('/abc')
    assert_salt_response(
        result, 'Invalid directory "/abc".', name='/abc', result=False
    )

  def test_validates_script_presence(self):
    result = make.configure('/tmp')
    assert_salt_response(
        result, 'Configure script not found in "/tmp".', result=False
    )

  @pytest.mark.usefixtures('test_dir')
  @pytest.mark.usefixtures('salt_opts')
  @pytest.mark.usefixtures('salt_dict_fails')
  def test_commands_fails(self, test_dir):
    result = make.configure(test_dir)
    assert_salt_response(
        result, 'Configure script failed with code 2.',
        name=test_dir, result=False
    )

  @pytest.mark.usefixtures('test_dir')
  @pytest.mark.usefixtures('salt_opts')
  @pytest.mark.usefixtures('salt_dict_success')
  def test_passes_validation(self, test_dir):
    result = make.configure(test_dir)
    assert_salt_response(
        result, 'Run configure script from "{0}".'.format(test_dir),
        name=test_dir
    )
