var World = {
  loaded: false,
  nijntjeSettings: {
    nijntje: {
      scale: 20,
    },
    auto: {
      scale: 600,
    },
  },

  init: function initFn() {
    this.createOverlays();
  },
  createOverlays: function createOverlaysFn() {
    this.targetCollectionResource = new AR.TargetCollectionResource(
      'assets/nijntjeInDeSpeeltuin.wtc',
      {
        onError: World.onError,
      }
    );

    this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
      maximumNumberOfConcurrentlyTrackableTargets: 2,
      extendedRangeRecognition: AR.CONST.IMAGE_RECOGNITION_RANGE_EXTENSION.ON,
      onTargetsLoaded: World.showInfoBar,
      onError: World.onError,
    });

    new AR.Model('assets/models/auto.wt3');
    new AR.Model('assets/models/glijbaan.wt3');
    new AR.Model('assets/models/klimboom.wt3');
    new AR.Model('assets/models/nijntje.wt3');
    new AR.Model('assets/models/papaNijntje.wt3');
    new AR.Model('assets/models/rekstok.wt3');
    new AR.Model('assets/models/ringen.wt3');
    new AR.Model('assets/models/schommel.wt3');
    new AR.Model('assets/models/wip.wt3');

    this.nijntjeTrackable = new AR.ImageTrackable(this.tracker, '*', {
      onImageRecognized: function (target) {
        /*
                    Create 3D model based on which target was recognized.
                 */
        var model = new AR.Model('assets/models/auto.wt3', {
          scale: World.nijntjeSettings['auto'].scale,
          rotate: {
            z: 180,
          },
          onError: World.onError,
        });

        /* Adds the model as augmentation for the currently recognized target. */
        this.addImageTargetCamDrawables(target, model);

        World.hideInfoBar();
      },
      onError: World.onError,
    });
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
