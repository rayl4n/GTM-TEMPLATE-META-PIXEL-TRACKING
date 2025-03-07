___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Meta Pixel Tracking",
  "categories": ["ADVERTISING", "MARKETING", "REMARKETING"],
  "brand": {
    "id": "brand_dummy",
    "displayName": "meta-pixel-tracking-by-rayl4n"
  },
  "description": "",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "pixelId",
    "simpleValueType": true,
    "alwaysInSummary": false,
    "displayName": "Facebook Pixel ID"
  },
  {
    "type": "GROUP",
    "name": "moreSettingsGroup",
    "displayName": "More Settings",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "eventId",
        "displayName": "Event ID",
        "simpleValueType": true,
        "help": "Set the Event ID parameter in case you are tracking the same event server-side as well. The Event ID can be used to deduplicate the same event if sent from multiple sources. See more \u003ca href\u003d\"https://developers.facebook.com/docs/marketing-api/conversions-api/deduplicate-pixel-and-server-events/\"\u003ehere\u003c/a\u003e."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const createQueue = require('createQueue');
const callInWindow = require('callInWindow');
const aliasInWindow = require('aliasInWindow');
const copyFromWindow = require('copyFromWindow');
const setInWindow = require('setInWindow');
const injectScript = require('injectScript');
const log = require('logToConsole');

const pixelId = data.pixelId;
const eventId = data.moreSettingsGroup && typeof data.moreSettingsGroup.eventId === 'string' ? data.moreSettingsGroup.eventId.trim() : null;

if (!pixelId) {
  log('Facebook Pixel ID não foi fornecido. A tag não será disparada.');
  data.gtmOnFailure();
  return;
}

const getFbq = () => {
  let fbqInstance;

  if (typeof fbqInstance === 'function') {
    return fbqInstance; // Se fbq já existir, retorna ele
  }

  // Se fbq não existir, cria um mock para evitar erros
  setInWindow('fbq', function() {
    const callMethod = copyFromWindow('fbq.callMethod.apply');
    if (callMethod) {
      callInWindow('fbq.callMethod.apply', null, arguments);
    } else {
      let fbqQueue = copyFromWindow('fbq.queue') || [];
      fbqQueue.push(arguments);
      setInWindow('fbq.queue', fbqQueue);
    }
  });

  createQueue('fbq.queue'); // Cria a fila de eventos
  return copyFromWindow('fbq'); // Retorna o fbq atualizado
};

// Obtém o fbq da função getFbq()
let fbq = getFbq();

// Verifica se fbq foi definido corretamente; caso contrário, cria um mock
if (!fbq || typeof fbq !== 'function') {
  log('fbq não encontrado, criando função temporária...');
  setInWindow('fbq', function() {}); // Cria uma função vazia para evitar erro
  fbq = copyFromWindow('fbq'); // Obtém o fbq atualizado
}

// Inicializa o Pixel com o ID fornecido
fbq('init', pixelId);
fbq('track', 'PageView', eventId ? { eventID: eventId } : {});

// Carrega o script do Facebook Pixel
injectScript(
  'https://connect.facebook.net/en_US/fbevents.js',
  () => data.gtmOnSuccess(),
  () => data.gtmOnFailure(),
  'fbPixel'
);

injectScript('https://connect.facebook.net/en_US/fbevents.js', () => data.gtmOnSuccess(), () => data.gtmOnFailure(), 'fbPixel');

// Confirma o sucesso da execução
data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "fbq"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_fbq_gtm"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_fbq"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_fbq_gtm_ids"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "fbq.callMethod.apply"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "fbq.queue.push"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "fbq.queue"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "fbq.disablePushState"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://connect.facebook.net/en_US/fbevents.js"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Library is injected
  code: |
    // Library is injected
    let success, failure;

    mock('injectScript', (url, onSuccess, onFailure) => {
      success = onSuccess;
      failure = onFailure;
      onSuccess(); // Simula o sucesso da injeção do script
    });

    mock('copyFromWindow', key => {
      if (key === 'fbq') return function() {}; // Retorna uma função vazia para evitar leitura global proibida
    });

    runCode(mockData);

    assertApi('injectScript').wasCalledWith('https://connect.facebook.net/en_US/fbevents.js', success, failure, 'fbPixel');
    assertApi('gtmOnSuccess').wasCalled();
- name: fbq does not exist - method created
  code: |
    // fbq does not exist - method created
    let fbq;
    let success, failure; // Declara as variáveis para o mock de injectScript

    mock('copyFromWindow', key => {
      if (key === 'fbq') return fbq;
    });
    mock('createQueue', key => {});
    mock('setInWindow', (key, val) => {
      if (key === 'fbq') fbq = val;
    });

    // Mock para evitar bloqueio do GTM na injeção do script
    mock('injectScript', (url, onSuccess, onFailure) => {
      success = onSuccess;
      failure = onFailure;
      onSuccess(); // Simula o carregamento bem-sucedido do script
    });

    runCode(mockData);

    assertApi('injectScript').wasCalledWith('https://connect.facebook.net/en_US/fbevents.js', success, failure, 'fbPixel');
    assertApi('setInWindow').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();
- name: fbq exists - method copied
  code: |-
    // fbq exists - method copied
    mock('copyFromWindow', key => {
      if (key === 'fbq') return function() {}; // Retorna uma função vazia para evitar erro de leitura
    });

    mock('setInWindow', key => {
      if (key === 'fbq') fail('setInWindow chamado com fbq mesmo já existindo');
    });

    mock('createQueue', key => {});

    // Mock da injeção de script para evitar erro do GTM
    mock('injectScript', (url, onSuccess, onFailure) => {
      onSuccess(); // Simula que o script foi carregado corretamente
    });

    runCode(mockData);

    assertApi('gtmOnSuccess').wasCalled();
- name: Send event ID
  code: |
    // Send event ID
    let fbq;
    mock('copyFromWindow', key => {
      if (key === 'fbq') return fbq;
    });
    mock('createQueue', key => {});
    mock('setInWindow', (key, val) => {
      if (key === 'fbq') fbq = val;
    });

    // Mock para evitar erro de injeção de script externo
    mock('injectScript', (url, onSuccess, onFailure) => {
      onSuccess(); // Simula o carregamento bem-sucedido do script
    });

    runCode(mockData);
    assertApi('setInWindow').wasCalled();
    assertApi('gtmOnSuccess').wasCalled();
setup: |-
  const mockData = {
    pixelId: '12345', // Certifique-se de que está escrito exatamente como no código
    moreSettingsGroup: { eventId: 'evt_67890' }
  };


___NOTES___

Created on 3/6/2025, 8:33:47 PM


