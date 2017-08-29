#!py

def _ACTION(P,C):
    action = {}

    action['install_collectd'] = {
        'pkg.installed': [
            {'name': 'collectd'}
        ]
    }

    action['config_collectd'] = {
        'file.managed': [
            {'name': P + 'salt.conf'},
            {'contents': C},
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
    if 'collectd' in __pillar__:
        config = __pillar__['collectd']['config']

        if __grains__['os'] == 'CentOS':
            path = "/etc/collectd.d/"
        elif __grains__['os'] == 'Ubuntu':
            path = "/etc/collectd/collectd.conf.d/"

        return _ACTION(path, config)
    else:
        message = "collectd missing in pillar data"
        return _EVENT(M)
