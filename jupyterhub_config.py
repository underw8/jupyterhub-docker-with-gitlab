import os
from subprocess import check_call
from oauthenticator.gitlab import LocalGitLabOAuthenticator

c = get_config()

# Pre-spawn Hook


def load_init_script(spawner):
    username = spawner.user.name
    check_call(['/srv/jupyterhub/bootstrap.sh', username])


c.Spawner.pre_spawn_hook = load_init_script

# Networking configs

c.JupyterHub.ip = '0.0.0.0'
c.JupyterHub.port = 8888


# Spawner configs

c.Spawner.notebook_dir = '~/'
c.Spawner.default_url = '/lab'

# OAuth configs

c.JupyterHub.authenticator_class = LocalGitLabOAuthenticator

c.LocalGitLabOAuthenticator.oauth_callback_url = os.environ['OAUTH_CALLBACK_URL']
c.LocalGitLabOAuthenticator.client_id = os.environ['GITLAB_CLIENT_ID']
c.LocalGitLabOAuthenticator.client_secret = os.environ['GITLAB_CLIENT_SECRET']

c.LocalGitLabOAuthenticator.add_user_cmd = [
    'adduser', '--home', '/home/USERNAME']

c.LocalGitLabOAuthenticator.create_system_users = True

# Whitlelist users and admins
# c.Authenticator.allowed_users = allowed_users = set()
c.Authenticator.admin_users = admin = set()
c.JupyterHub.admin_access = True
pwd = os.path.dirname(__file__)
with open(os.path.join(pwd, 'userlist')) as f:
    for line in f:
        if not line:
            continue
        parts = line.split()
        # in case of newline at the end of userlist file
        if len(parts) >= 1:
            name = parts[0]
            # allowed_users.add(name)
            if len(parts) > 1 and parts[1] == 'admin':
                admin.add(name)


# Persist data configs

# Persist hub data on volume mounted inside container
# data_dir = os.environ.get('DATA_VOLUME_CONTAINER', '/data')

# c.JupyterHub.cookie_secret_file = os.path.join(data_dir,
#                                                'jupyterhub_cookie_secret')

# c.JupyterHub.db_url = 'postgresql://postgres:{password}@{host}/{db}'.format(
#     host=os.environ['POSTGRES_HOST'],
#     password=os.environ['POSTGRES_PASSWORD'],
#     db=os.environ['POSTGRES_DB'],
# )
