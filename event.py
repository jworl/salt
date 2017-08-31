def EVENT(message):
    event = {}

    event_id = 'salt/event/*/alert'
    actions['send_event'] = {
        'event.send': [
            {'name': event_id},
            {'data': {
                "message": message
            }}
        ]
    }

    return event
