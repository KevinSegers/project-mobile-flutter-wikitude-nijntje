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

//localhost Kevin
var edgeService = '192.168.0.199:8050';

//localhost Michal
//var edgeService = '192.168.0.221:8050';

var World = {
  loaded: false,
  nijntjeSettings: settingsPerItem(),

  init: function initFn() {
    this.createOverlays();
  },

  createOverlays: function createOverlaysFn() {
    /*
            First a AR.TargetCollectionResource is created with the path to the Wikitude Target Collection(.wtc) file.
            This .wtc file can be created from images using the Wikitude Studio. More information on how to create them
            can be found in the documentation in the TargetManagement section.
            Each target in the target collection is identified by its target name. By using this
            target name, it is possible to create an AR.ImageTrackable for every target in the target collection.
         */
    this.targetCollectionResource = new AR.TargetCollectionResource(
      'assets/nijntje.wtc',
      {
        onError: World.onError,
      }
    );

    /*
      This resource is then used as parameter to create an AR.ImageTracker. Optional parameters are passed as
      object in the last argument. In this case a callback function for the onTargetsLoaded trigger is set. Once
      the tracker loaded all of its target images this callback function is invoked. We also set the callback
      function for the onError trigger which provides a sting containing a description of the error.

      To enable simultaneous tracking of multiple targets 'maximumNumberOfConcurrentlyTrackableTargets' has
      to be set.
          
    */
    this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
      maximumNumberOfConcurrentlyTrackableTargets: 1, // a maximum of 1 page can be tracked simultaneously
      /*
    Disables extended range recognition.
    The reason for this is that extended range recognition requires more processing power and with multiple
    targets the SDK is trying to recognize targets until the maximumNumberOfConcurrentlyTrackableTargets
    is reached and it may slow down the tracking of already recognized targets.
    */
      extendedRangeRecognition: AR.CONST.IMAGE_RECOGNITION_RANGE_EXTENSION.OFF,
      onTargetsLoaded: World.showInfoBar,
      onError: World.onError,
    });

    /*
    Pre-load models such that they are available in cache to avoid any slowdown upon first recognition.
    */
    new AR.Model('assets/models/auto.wt3');
    new AR.Model('assets/models/glijbaan.wt3');
    new AR.Model('assets/models/klimboom.wt3');
    new AR.Model('assets/models/nijntje.wt3');
    new AR.Model('assets/models/papaNijntje.wt3');
    new AR.Model('assets/models/mamaNijntje.wt3');
    new AR.Model('assets/models/rekstok.wt3');
    new AR.Model('assets/models/ringen.wt3');
    new AR.Model('assets/models/schommel.wt3');
    new AR.Model('assets/models/trampoline.wt3');
    new AR.Model('assets/models/wip.wt3');

    /*
    Note that this time we use "*" as target name. That means that the AR.ImageTrackable will respond to
    any target that is defined in the target collection. You can use wildcards to specify more complex name
    matchings. E.g. 'target_?' to reference 'target_1' through 'target_9' or 'target*' for any targets
    names that start with 'target'.
    */
    this.nijntjeTrackable = new AR.ImageTrackable(this.tracker, '*', {
      onImageRecognized: function (target) {
        // var number = (target.name).substring(4);
        // var testItems = getItems(target.name, edgeService);
        // var testItems4;

        // console.log(
        //   testItems.then((data) => {
        //     console.log(data);
        //     testItems4 = data;
        //   })
        // );
        // var testItems3;
        // const testItems2 = async () => {
        //   testItems3 = await getItems(target.name, edgeService);
        // };

        // testItems2();
        // console.log(testItems4);

        //  Create 3D models based on which target (target.name = page) was recognized
        ItemsPerPage[target.name].items.forEach((item) => {
          console.log(item);
          var model = new AR.Model('assets/models/' + item + '.wt3', {
            scale: World.nijntjeSettings[item].scale,
            rotate: {
              x: World.nijntjeSettings[item].rotatex,
              z: World.nijntjeSettings[item].rotatez,
            },
            translate: {
              x: World.nijntjeSettings[item].translatex,
              y: World.nijntjeSettings[item].translatey,
              z: World.nijntjeSettings[item].translatez,
            },
            onError: World.onError,
          });

          this.addImageTargetCamDrawables(target, model);
          setTimeout(function () {
            World.animate(
              target.name,
              item,
              model,
              World.nijntjeSettings[item].translatex,
              World.nijntjeSettings[item].translatey,
              World.nijntjeSettings[item].translatez
            );
          }, 100);
        });

        setSeen(target.name, edgeService);

        World.hideInfoBar();
      },
      onError: World.onError,
    });
  },

  animate: function (page, item, model, offsetX, offsetY, offsetZ) {
    var distance,
      nijntjejumpingup,
      nijntjejumpingdown,
      animationGroup,
      riding,
      parking,
      riding2,
      walkingrotate,
      walking,
      walkingToCar,
      steppingInCar,
      steppingInCarWaiting,
      rotateToLeft,
      animationGroupStart,
      walking2,
      walkingTranslate,
      walkingRotate;
    if (page === 'page1' && item === 'nijntje') {
      //nijntje jumping up and down
      distance = 0.3;
      nijntjejumpingup = new AR.PropertyAnimation(
        model,
        'translate.z',
        offsetZ,
        offsetZ + distance,
        1000
      );
      nijntjejumpingdown = new AR.PropertyAnimation(
        model,
        'translate.z',
        offsetZ + distance,
        offsetZ,
        800
      );
      animationGroup = new AR.AnimationGroup(
        AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
        [nijntjejumpingup, nijntjejumpingdown]
      );
      animationGroup.start(-1);
    } else if (page === 'page2' || page === 'page12') {
      if (item === 'auto') {
        // riding auto - standing still - riding off page
        riding = new AR.PropertyAnimation(
          model,
          'translate.x',
          offsetX,
          offsetX + 1,
          4500
        );
        parking = new AR.PropertyAnimation(
          model,
          'translate.x',
          offsetX + 1,
          offsetX + 1,
          2000
        );
        riding2 = new AR.PropertyAnimation(
          model,
          'translate.x',
          offsetX + 1,
          offsetX + 3,
          5000
        );
        animationGroup = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
          [riding, parking, riding2]
        );
        animationGroup.start(-1);
      } else {
        // nijntje + parents walking towards car + "disappear" in car
        walkingrotate = new AR.PropertyAnimation(
          model,
          'translate.y',
          offsetY,
          offsetY + 0.8,
          5000
        );
        walking = new AR.PropertyAnimation(
          model,
          'translate.x',
          offsetX,
          offsetX - 0.18,
          5000
        );
        walkingToCar = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL,
          [walkingrotate, walking]
        );
        steppingInCar = new AR.PropertyAnimation(model, 'scale', null, 0, 0);
        steppingInCarWaiting = new AR.PropertyAnimation(
          model,
          'translate.x',
          offsetX - 0.18,
          offsetX - 0.18,
          1000
        );
        animationGroup = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
          [walkingToCar, steppingInCarWaiting, steppingInCar]
        );
        animationGroup.start(-1);
      }
    } else if (page === 'page3') {
      // nijntje + parents waling towards swing
      rotateToLeft = new AR.PropertyAnimation(
        model,
        'rotate.z',
        null,
        45,
        2000
      );
      walking = new AR.PropertyAnimation(
        model,
        'translate.x',
        offsetX,
        offsetX + 1.5,
        2000
      );
      animationGroupStart = new AR.AnimationGroup(
        AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL,
        [rotateToLeft, walking]
      );
      walking2 = new AR.PropertyAnimation(
        model,
        'translate.x',
        offsetX + 1.5,
        offsetX + 4,
        2000
      );
      animationGroup = new AR.AnimationGroup(
        AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
        [animationGroupStart, walking2]
      );
      animationGroup.start(-1);
    } else if (page === 'page4' || page === 'page5') {
      if (item === 'nijntje') {
        // nijntje walking toward play ground
        walkingTranslate = new AR.PropertyAnimation(
          model,
          translate.y,
          offsetY,
          offsetY + 1,
          2000
        );
        walkingRotate = new AR.PropertyAnimation(
          model,
          'rotate.z',
          null,
          180,
          2000
        );
        walking = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL,
          [walkingTranslate, walkingRotate]
        );
        animationGroup = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
          [walking]
        );
        animationGroup.start(-1);
      }
    }
  },

  onError: function onErrorFn(error) {
    alert(error);
  },

  hideInfoBar: function hideInfoBarFn() {
    document.getElementById('infoBox').style.display = 'none';
  },

  showInfoBar: function worldLoadedFn() {
    document.getElementById('infoBox').style.display = 'table';
    document.getElementById('loadingMessage').style.display = 'none';
  },
};

World.init();
