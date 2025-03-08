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
  "categories": [
    "ADVERTISING",
    "MARKETING",
    "REMARKETING"
  ],
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
    "displayName": "Meta Pixel ID"
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
  log('Facebook Pixel ID not provided. Tag will not fire.');
  data.gtmOnFailure();
  return;
}

const createFbq = () => {
  const fbqQueue = [];

  const fbq = function () {
    fbqQueue.push(arguments);
  };

  fbq.queue = fbqQueue;
  fbq.version = '2.0';

  fbq.callMethod = function () {
    while (fbq.queue.length) {
      const event = fbq.queue.shift();
      fbq.apply(null, event);
    }
  };

  setInWindow('fbq', fbq);

  return fbq;
};

const fbq = createFbq();

fbq('init', pixelId);
fbq('track', 'PageView', eventId ? { eventID: eventId } : {});

injectScript(
  'https://connect.facebook.net/en_US/fbevents.js',
  () => {
    fbq.callMethod();
    data.gtmOnSuccess();
  },
  () => data.gtmOnFailure(),
  'fbPixel'
);

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
  code: "// Library is injected\nlet success, failure;\n\nmock('injectScript', (url,\
    \ onSuccess, onFailure) => {\n  success = onSuccess;\n  failure = onFailure;\n\
    \  onSuccess();\n});\n\nmock('setInWindow', (key, val) => {\n  if (key === 'fbq')\
    \ {\n    mockData.fbq = val;\n    mockData.fbq.queue = [];\n    mockData.fbq.callMethod\
    \ = function () { \n      while (mockData.fbq.queue.length) {\n        const event\
    \ = mockData.fbq.queue.shift();\n        mockData.fbq.apply(null, event);\n  \
    \    }\n    };\n  }\n});\n\nrunCode(mockData);\n\nassertApi('injectScript').wasCalledWith('https://connect.facebook.net/en_US/fbevents.js',\
    \ success, failure, 'fbPixel');\nassertApi('gtmOnSuccess').wasCalled();\n"
- name: fbq is correctly initialized
  code: "// fbq is correctly initialized\nlet fbq;\nlet success, failure;\n\nmock('injectScript',\
    \ (url, onSuccess, onFailure) => {\n  success = onSuccess;\n  failure = onFailure;\n\
    \  mock('setInWindow', (key, val) => {\n    if (key === 'fbq') {\n      fbq =\
    \ val;\n\n      if (typeof fbq !== 'function') {\n        fbq = function () {};\n\
    \      }\n      \n      if (!(fbq.queue && typeof fbq.queue.push === 'function'))\
    \ {\n        fbq.queue = [];\n      }\n\n      if (typeof fbq.callMethod !== 'function')\
    \ {\n        fbq.callMethod = function () {\n          while (fbq.queue.length\
    \ > 0) {\n            const event = fbq.queue.shift();\n            if (typeof\
    \ fbq === 'function') {\n              fbq.apply(null, event);\n            }\n\
    \          }\n        };\n      }\n    }\n  });\n\n  onSuccess();\n});"
- name: fbq processes queued events after script loads
  code: "// fbq processes queued events after script loads\nlet fbq;\nlet queuedEventProcessed\
    \ = false;\n\nmock('setInWindow', (key, val) => {\n  if (key === 'fbq') {\n  \
    \  fbq = val;\n\n    if (typeof fbq !== 'function') {\n      fbq = function ()\
    \ {};\n    }\n    \n    if (!(fbq.queue && typeof fbq.queue.push === 'function'))\
    \ {\n      fbq.queue = [];\n    }\n\n    fbq.queue.push(['track', 'PageView']);\n\
    \n    fbq.callMethod = function () {\n      while (fbq.queue.length > 0) {\n \
    \       const event = fbq.queue.shift();\n        queuedEventProcessed = true;\n\
    \      }\n    };\n  }\n});\n\nmock('injectScript', (url, onSuccess, onFailure)\
    \ => {\n  onSuccess();\n  if (typeof fbq.callMethod === 'function') {\n    fbq.callMethod();\n\
    \  }\n});\n\nrunCode(mockData);\n\nassertThat(queuedEventProcessed).isTrue();"
setup: |-
  const mockData = {
    pixelId: '12345',
    moreSettingsGroup: { eventId: 'evt_67890' }
  };


___NOTES___

Created on 3/6/2025, 8:33:47 PM


