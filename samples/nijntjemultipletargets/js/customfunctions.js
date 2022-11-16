// get items form DB => Not used yet
async function getItems(pageNumber, edgeService) {
  let number = pageNumber.substring(4);
  const options = {
    method: 'GET',
    headers: { 'Content-Type': 'application/json' },
  };
  await fetch(
    'http://' +
      edgeService +
      '/interactivebooks/booktitle/Nijntje in de speeltuin/pagenumber/' +
      number +
      '/items',
    options
  )
    .then((response) => {
      if (!response.ok) {
        throw new Error(`HTTP error: ${response.status}`);
      }
      return response.json();
    })
    .then((data) => {
      console.log('ITEMS!!!!' + data);
    })
    .catch((error) => {
      console.error(`Could not get items: ${error}`);
    });
}

// set page of a book seen
async function setSeen(pageNumber, edgeService) {
  let number = pageNumber.substring(4);
  console.log('pageNumber' + number);
  const options = {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
  };

  try {
    const url =
      'http://' +
      edgeService +
      '/interactivebooks/pages/booktitle/Nijntje%20in%20de%20speeltuin/pagenumber/' +
      number;
    console.log('url: ' + url);
    const response = await fetch(url, options);

    if (!response.ok) {
      throw new Error('Http error:' + response.status);
    }
  } catch (error) {
    console.error(error);
  }
}

var ItemsPerPage = {
  page1: {
    items: ['nijntje', 'papaNijntje', 'mamaNijntje'],
  },
  page2: {
    items: ['nijntje', 'papaNijntje', 'auto', 'mamaNijntje'],
  },
  page3: {
    items: ['nijntje', 'papaNijntje', 'mamaNijntje'],
  },
  page4: {
    items: ['nijntje', 'schommel'],
  },
  page5: {
    items: ['nijntje', 'ringen'],
  },
  page6: {
    items: ['nijntje', 'rekstok'],
  },
  page7: {
    items: ['nijntje', 'klimboom'],
  },
  page8: {
    items: ['nijntje', 'glijbaan'],
  },
  page9: {
    items: ['nijntje', 'wip', 'papaNijntje'],
  },
  page10: {
    items: ['nijntje', 'trampoline'],
  },
  page11: {
    items: ['nijntje', 'papaNijntje', 'mamaNijntje'],
  },
  page12: {
    items: ['nijntje', 'papaNijntje', 'auto', 'mamaNijntje'],
  },
};

//settings per item
function settingsPerItem() {
  return {
    auto: {
      scale: 0.006,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -3,
      translatey: -0.5,
      translatez: -1,
    },

    papaNijntje: {
      scale: 0.05,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.8,
      translatey: -0.8,
      translatez: -0.5,
    },

    mamaNijntje: {
      scale: 0.05,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.2,
      translatey: -0.8,
      translatez: -0.5,
    },

    nijntje: {
      scale: 0.01,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.25,
      translatey: -0.5,
      translatez: -0.5,
    },

    schommel: {
      scale: 0.008,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.3,
      translatey: 0.4,
      translatez: 0,
    },

    ringen: {
      scale: 0.008,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.3,
      translatey: 0.4,
      translatez: 0,
    },

    rekstok: {
      scale: 0.005,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.2,
      translatey: 0.4,
      translatez: 0,
    },

    klimboom: {
      scale: 0.02,
      rotatex: 0,
      rotatey: 0,
      rotatez: 180,
      translatex: -0.1,
      translatey: 1,
      translatez: -1,
    },

    glijbaan: {
      scale: 0.3,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.5,
      translatey: 0.4,
      translatez: 0,
    },

    trampoline: {
      scale: 0.1,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.2,
      translatey: 0.02,
      translatez: 0,
    },

    wip: {
      scale: 0.5,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.6,
      translatey: 0.4,
      translatez: 0,
    },
  };
}
