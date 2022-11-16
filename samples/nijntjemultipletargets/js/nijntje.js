var World = {
  loaded: false,
  nijntjeSettings: settingsPerItem(),
  edgeService: '',

  init: function initFn() {
    this.createOverlays();
  },

  createOverlays: function createOverlaysFn() {
    this.targetCollectionResource = new AR.TargetCollectionResource(
      'assets/nijntje.wtc',
      {
        onError: World.onError,
      }
    );

    this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
      maximumNumberOfConcurrentlyTrackableTargets: 1, // a maximum of 1 page can be tracked simultaneously

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

    this.nijntjeTrackable = new AR.ImageTrackable(this.tracker, '*', {
      onImageRecognized: function (target) {
        getItems(target.name, World.edgeService);
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

        setSeen(target.name, World.edgeService);

        World.hideInfoBar();
      },
      onError: World.onError,
    });
  },

  // Model animantions
  animate: function (page, item, model, offsetX, offsetY, offsetZ) {
    var nijntjeJumpingUp,
      nijntjeJumpingDown,
      animationGroup,
      distance,
      riding,
      parking,
      riding2,
      walking,
      walkingToCar,
      steppingInCar,
      steppingInCarWaiting,
      rotateToLeft,
      animationGroupStart,
      walking2,
      walkingTranslateX,
      walkingTranslateY,
      walkingRotate;
    if (page === 'page1' && item === 'nijntje') {
      //nijntje jumping up and down
      distance = 0.3;
      nijntjeJumpingUp = new AR.PropertyAnimation(
        model,
        'translate.z',
        offsetZ,
        offsetZ + distance,
        1000
      );
      nijntjeJumpingDown = new AR.PropertyAnimation(
        model,
        'translate.z',
        offsetZ + distance,
        offsetZ,
        800
      );
      animationGroup = new AR.AnimationGroup(
        AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
        [nijntjeJumpingUp, nijntjeJumpingDown]
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
          4000
        );
        animationGroup = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
          [riding, parking, riding2]
        );
        animationGroup.start(-1);
      } else {
        // nijntje + parents walking towards car + "disappear" in car
        walkingRotate = new AR.PropertyAnimation(
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
          [walkingRotate, walking]
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
      // nijntje + parents walking towards swing
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
    } else if (
      page === 'page4' ||
      page === 'page5' ||
      page === 'page6' ||
      page === 'page8'
    ) {
      if (item === 'nijntje') {
        // nijntje walking toward play ground
        distance = 0.2;
        walkingTranslateY = new AR.PropertyAnimation(
          model,
          'translate.y',
          offsetY,
          offsetY + 0.8,
          4000
        );
        walkingTranslateX = new AR.PropertyAnimation(
          model,
          'translate.x',
          offsetX,
          offsetX + 0.4,
          2
        );
        walkingRotate = new AR.PropertyAnimation(
          model,
          'rotate.z',
          null,
          180,
          2
        );
        nijntjeJumpingUp = new AR.PropertyAnimation(
          model,
          'translate.z',
          offsetZ,
          offsetZ + distance,
          1000
        );
        nijntjeJumpingDown = new AR.PropertyAnimation(
          model,
          'translate.z',
          offsetZ + distance,
          offsetZ,
          800
        );
        walking = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL,
          [walkingTranslateX, walkingRotate]
        );
        animationGroup = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
          [
            walking,
            walkingTranslateY,
            nijntjeJumpingUp,
            nijntjeJumpingDown,
            nijntjeJumpingUp,
            nijntjeJumpingDown,
            nijntjeJumpingUp,
            nijntjeJumpingDown,
            nijntjeJumpingUp,
            nijntjeJumpingDown,
          ]
        );
        animationGroup.start(-1);
      }
    } else {
      if (item === 'nijntje') {
        distance = 0.2;
        nijntjeJumpingUp = new AR.PropertyAnimation(
          model,
          'translate.z',
          offsetZ,
          offsetZ + distance,
          1000
        );
        nijntjeJumpingDown = new AR.PropertyAnimation(
          model,
          'translate.z',
          offsetZ + distance,
          offsetZ,
          800
        );

        animationGroup = new AR.AnimationGroup(
          AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL,
          [nijntjeJumpingUp, nijntjeJumpingDown]
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

  newData: function newDataFn(url) {
    World.edgeService = url;
  },
};

World.init();
