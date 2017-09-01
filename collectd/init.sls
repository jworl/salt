#!py

import salt.states.event
import imp
# import salt.states.file_contents

def _ACTION(D):
    action = {}

    PKGS = D['pkgs']
    PATH = D['path']
    CONF = D['conf']

    # action['install_collectd'] = {
    #     'pkg.installed': [
    #         {'pkgs': PKGS}
    #     ]
    # }
    install = imp.load_source('PKGS_INSTALL', '/srv/salt/pkgs_install.py')
    action['install_collectd'] = install.PKGS_INSTALL(PKGS)

    action['config_collectd'] = {
        'file.managed': [
            {'name': PATH + 'salted.conf'},
            {'contents': CONF},
            {'user': 'root'},
            {'group': 'root'},
            {'mode': 644},
            {'require': [
                {'pkg': 'install_collectd'}
            ]}
        ]
    }

    action['start_collectd'] = {
        'service.running': [
            {'name': 'collectd'},
            {'enable': True},
            {'watch': [
                {'file': 'config_collectd'}
            ]}
        ]
    }

    return action

def run():
    if 'collectd' not in __pillar__:
        message = "collectd missing in pillar data"
        return EVENT(M)

    elif __pillar__['collectd']['path'] is None:
        message = "collectd missing path, what OS is this?"
        return EVENT(M)

    else:
        DATA = __pillar__['collectd']
        return _ACTION(DATA)
