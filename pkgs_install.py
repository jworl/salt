def PKGS_INSTALL(PKGS, **REQUISITE):
    STATE = {
        'pkg.installed': [
            {'pkgs': PKGS}
        ]
    }

    if 'requisite' in REQUISITE:
        STATE['file.managed'].append(REQUISITE['requisite'])

    return STATE
