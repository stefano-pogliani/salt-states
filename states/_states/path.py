from salt.states import file


DEFAULT_PROFILE_PATH = "/etc/profile.d/salt-path.sh"
MANAGED_FILE_STATE = "salt_managed_path"
PROFILE_PATH_CONFIG_NAME = "salt-path-location"


# Managed file.
managed_file_added = False
def _ensure_managed_file():
  global managed_file_added
  if managed_file_added:
    return

  file.managed(
      _get_filename(),
      source="_states/path.profile",
      template="jinja"
  )
  managed_file_added = True


def _get_filename():
  return DEFAULT_PROFILE_PATH


# Accumulated shorthand
def include(name, path=None):
  """
  Includes the given path in the genrated PATH extention profile.

  name
    The id of the state being enforced.

  path
    The path to include in $PATH on the managed system.
  """
  # Ensure file exists.
  filename = _get_filename()
  return file.accumulated(
      "salt-path-accumulator", filename, path,
      require_in=["file: " + filename]
  )
