 var ItemsPerPage = {
    "page1":{
      items: ["nijntje", "papaNijntje" ,"mamaNijntje"]},
    "page2":{ 
      items: ["nijntje","papaNijntje","auto","mamaNijntje" ]},
    "page3":{
      items:  ["nijntje", "papaNijntje","mamaNijntje"]
    },
    "page4":{
      items:  ["nijntje", "schommel"]},
    "page5":{
      items: ["nijntje", "ringen"] },
    "page6":{
      items: ["nijntje","rekstok"]},
    "page7":{
      items: ["nijntje", "klimboom"]},
    "page8":{
      items: ["nijntje", "glijbaan"]},
    "page9":{
      items: ["nijntje", "wip", "papaNijntje"]
    },
    "page10":{
      items: ["nijntje", "trampoline"]
    },
    "page11":{
      items: ["nijntje","papaNijntje", "mamaNijntje"]
    },
    "page12":{
      items: ["nijntje","papaNijntje","auto","mamaNijntje"]},
  };

var World = {
  loaded: false,
  nijntjeSettings: {
    klimboom:{
      scale: 0.01,
      rotatex: 90,
      rotatez: 180,
      translatex: 0,
      translatey: -1
    }, 
    auto:{
      scale: 0.006,
      rotatex: 270,
      rotatez: 0,
      translatex: -2,
      translatey: -0.05 
    },

    papaNijntje:{
      scale: 0.2,
      rotatex: -90,
      rotatez: 0,
      translatex: 0,
      translatey: 0,

    }, 

    nijntje:{
      scale: 0.008,
      rotatex: -90,
      rotatez: 0,
      translatex: -0.5,
      translatey: -0.5,

    }, 

    glijbaan:{
      scale: 0.5,
      rotatex: -90,
      rotatez: 0 ,
      translatex: -0.5,
      translatey: -0.5, 
    },

    schommel:{
      scale: 0.01,
      rotatex:  -90,
      rotatez: 0,
      translatex: -0.3,
      translatey: -0.3, 
    },

    ringen:{
      scale: 0.01,
      rotatex:  -90,
      rotatez: 0,
      translatex: -1,
      translatey: -1,
    }, 

    rekstok:{
      scale: 0.01,
      rotatex:  -90,
      rotatez: 0,
      translatex: -1,
      translatey: -1,
    }, 



    trampoline:{
      scale: 0.08,
      rotatex: -90,
      rotatez: 0 ,
      translatex: -0.5,
      translatey: -0.5, 
    }, 

    wip:{
      scale: 0.5,
      rotatex: -90,
      rotatez: 0 ,
      translatex: -1,
      translatey: -1, 
    },

  },


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
            to be set.
         */
    this.tracker = new AR.ImageTracker(this.targetCollectionResource, {
      maximumNumberOfConcurrentlyTrackableTargets: 1, // a maximum of 5 targets can be tracked simultaneously
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
   // new AR.Model('assets/models/mamaNijntje.wt3');
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
        /*
                    Create 3D model based on which target was recognized.
                 */
      //  items =  JSON.parse(target.metadata.items);
    //    metadat = JSON.parse(target.metadata)
      let targetPage = target.name;  
        console.log(targetPage);   
        console.log(ItemsPerPage[targetPage].items);
        console.log(ItemsPerPage[targetPage].items[0]) ;    

 

         (ItemsPerPage[targetPage].items).forEach(item => {
           var model = new AR.Model('assets/models/' + item + '.wt3', {
             scale: World.nijntjeSettings[item].scale,
             rotate:{
              x: World.nijntjeSettings[item].rotatex,
              z: World.nijntjeSettings[item].rotatez,
            },
             translate:{
               x: World.nijntjeSettings[item].translatex,
               y: World.nijntjeSettings[item].translatey
            }, 
             onError: World.onError,
           }
           );

         this.addImageTargetCamDrawables(target, model);



       });            
      //   var model = new AR.Model('assets/models/' + 'wip' + '.wt3', {
      //  //   scale: World.nijntjeSettings[target.name].scale,
      //     scale: 0.5,
      //     rotate: {
      //       z: 0,
      //       x: -90,
      //     },
      //     translate: {
      //       x: -0.5,
      //       y: 0
      //     },
        
      //     onError: World.onError,
      //   });

        /* Adds the model as augmentation for the currently recognized target. */
       // this.addImageTargetCamDrawables(target, model);

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
