def FILE_CONTENTS(FILE, CONTENT, USER, GROUP, MODE, **REQUISITE):
    STATE = {
        'file.managed': [
            {'name': FILE},
            {'contents': CONTENT},
            {'user': USER},
            {'group': GROUP},
            {'mode': MODE}
        ]
    }

    if 'requisite' in REQUISITE:
        STATE['file.managed'].append(REQUISITE['requisite'])

    return STATE
