from os import path

from salt.exceptions import CommandExecutionError


def make_result(name, comment):
  return {
    'changes': None,
    'comment': comment,
    'name':    name,
    'result':  True
  }


def fail_state(result, comment):
  result['comment'] = comment
  result['result']  = False
  return result


def configure(name, stdout=None, stderr=None, user=None, options=None):
  options = options if options is not None else {}
  result  = make_result(name, 'Run configure script from "{0}".'.format(name))

  # Validate name as valid path.
  if not path.isdir(name):
    return fail_state(result, 'Invalid directory "{0}".'.format(name))

  # Validate configure script exists.
  if not path.isfile(path.join(name, 'configure')):
    return fail_state(
        result, 'Configure script not found in "{0}".'.format(name)
    )

  if __opts__['test']:
    result['comment'] = 'Would run ./configure from "{0}".'.format(name)
    result['result']  = None
    return result

  # Run command with __salt__['cmdmod.retcode'].
  try:
    command = './configure'
    for (option, value) in options:
      command += ' --' + option + "=" + value

    ret_code = __salt__['cmd.retcode'](
      './configure', cwd=name, stdout=stdout, stderr=stderr,
      runas=user
    )

    if ret_code != 0:
      return fail_state(
          result, 'Configure script failed with code {0}.'.format(ret_code)
      )

  except CommandExecutionError as ex:
    return fail_state(result, str(ex))

  # Return salt response.
  return result


def install(name, stdout=None, stderr=None, user=None, group=None):
  pass


def target(name, target=None, stdout=None, stderr=None, user=None, group=None):
  pass
