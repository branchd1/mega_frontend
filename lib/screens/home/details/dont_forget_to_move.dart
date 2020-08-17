final Map<String, dynamic> jsonDataDelete = {
  'admin': {
    'home': {
      'metadata': {
        'show_back_button': 'false'
      },
      'components': [
        {
          'text': {
            'value': 'hello',
          },
        },
        {
          'button': {
            'value': 'hey',
            'action': {
              'action_type': 'change_page',
              'new_page': 'second',
              'page_params': {
                'name': 'from_second', // param "name" value can be gotten from element of id 1
              }
            }
          }
        }
      ]
    },
    'second': {
      'components': [
        {
          'text': {
            'value': 'second',
          },
        },
        {
          'button': {
            'value': 'second_button',
            'action': {
              'action_type': 'change_page',
              'new_page': 'third', // specify name of new page
            }
          }
        }
      ]
    },
    'third': {
      'components': [
        {
          'form': {
            'action': {
              'action_type': 'save',
              'method': 'post',
              'access': 'user',
              'tag': 'users_email'
            },
            'body': [
              {
                'input': {
                  'type': 'email',
                  'name': 'email',
                }
              },
              {
                'stuffing': {
                  'height': '20',
                }
              },
              {
                'input': {
                  'type': 'text',
                  'name': 'first_name',
                  'hint': 'first name *',
                  'validators': {
                    'required':'',
                    'min_2':'',
                    'max_10':''
                  }
                }
              },
              {
                'submit_button': {
                  'value': 'submit',
                }
              }
            ]
          }
        }
      ]
    },
  },
  'member': {
    'home': {
      'components': [
        {
          'text': {
            'value': 'hi'
          }
        }
      ]
    }
  }
};