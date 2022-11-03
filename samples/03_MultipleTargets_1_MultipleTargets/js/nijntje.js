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
    
    auto:{
      scale: 0.006,
      rotatex: 0,
      rotatey: 0,
      rotatez: -90,
      translatex: -3.5,
      translatey: -1, 
      translatez: -2
    },

    papaNijntje:{
      scale: 0.05,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.8 ,
      translatey: -0.8,
      translatez: -0.5
    },

    mamaNijntje:{
      scale: 0.05,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex:  -0.2 ,
      translatey: -0.8,
      translatez: -0.5
    },

    nijntje:{
      scale: 0.006,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.25,
      translatey: -0.5,
      translatez: 0
    }, 

    schommel:{
      scale: 0.008,
      rotatex:  0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.3,
      translatey: 0.4, 
      translatez: 0
    },

    ringen:{
      scale: 0.008,
      rotatex:  0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.3,
      translatey: 0.4,
      translatez: 0
    }, 

    rekstok:{
      scale: 0.005,
      rotatex:  0,
      rotatey: 0,
      rotatez: 0,
      translatex: -0.5,
      translatey: 1,
      translatez: 0
    }, 
    
    klimboom:{
      scale: 0.02,
      rotatex: 0,
      rotatey: 0,
      rotatez: 180,
      translatex: 0.1,
      translatey: 0.8, 
      translatez: -1
    }, 

    glijbaan:{
      scale: 0.3,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0 ,
      translatex: -0.5,
      translatey: 0.4, 
      translatez: 0
    },


    trampoline:{
      scale: 0.1,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0 ,
      translatex:-0.2,
      translatey: 0.02, 
      translatez: 0
    }, 

    wip:{
      scale: 0.5,
      rotatex: 0,
      rotatey: 0,
      rotatez: 0 ,
      translatex: -0.6,
      translatey: 0.4, 
      translatez: 0
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
    this.targetCollectionResource = new AR.TargetCollectionResource('assets/nijntje.wtc',{
        onError: World.onError
      });

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
    var nijntje



    /*
    Note that this time we use "*" as target name. That means that the AR.ImageTrackable will respond to
    any target that is defined in the target collection. You can use wildcards to specify more complex name
    matchings. E.g. 'target_?' to reference 'target_1' through 'target_9' or 'target*' for any targets
    names that start with 'target'.
    */
    this.nijntjeTrackable = new AR.ImageTrackable(this.tracker, '*', {
      onImageRecognized: function (target) {

      //  Create 3D models based on which target was recognized
        (ItemsPerPage[target.name].items).forEach(item => {
          console.log(item);
           var model = new AR.Model('assets/models/' + item + '.wt3', {
             scale: World.nijntjeSettings[item].scale,
             rotate:{
              x: World.nijntjeSettings[item].rotatex,
              z: World.nijntjeSettings[item].rotatez,
            },
             translate:{
               x: World.nijntjeSettings[item].translatex,
               y: World.nijntjeSettings[item].translatey, 
               z: World.nijntjeSettings[item].translatez,
            }, 
            onError: World.onError,
           }
           );
         this.addImageTargetCamDrawables(target, model);
         setTimeout(function() { World.animate(target.name, item, model, World.nijntjeSettings[item].translatex, World.nijntjeSettings[item].translatey, World.nijntjeSettings[item].translatez); }, 100);
       });            
 
      World.hideInfoBar();
      },
      onError: World.onError,
    });
  },

  animate: function(page, item, model, offsetX, offsetY, offsetZ){
    if(page === "page1" && item === "nijntje"){
      var distance = 0.3;
      var nijntjejumpingup = new AR.PropertyAnimation(model, "translate.z", offsetZ,offsetZ+distance, 1000 );
      var nijntjejumpingdown = new AR.PropertyAnimation(model, "translate.z", offsetZ + distance , offsetZ, 800 );
      var animationGroup = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [nijntjejumpingup, nijntjejumpingdown])
      animationGroup.start(-1);
    }

    else if(page==="page2"){
      if(item ==="auto"){
        distance = 0.05
        // var carTurningFrontRotation = new AR.PropertyAnimation(model, "rotate.z", 0, 270, 5000);  
        // var carTurningFrontTranslationX = new AR.PropertyAnimation(model, "translate.x", offsetX, offsetX+distance*1, 5000);
        // var carTurningFrontTranslationY = new AR.PropertyAnimation(model, "translate.y", offsetY, offsetY+distance*-1, 5000);
        // var carTurningFront = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [carTurningFrontRotation, carTurningFrontTranslationX, carTurningFrontTranslationY]);
         var carRidingFront = new AR.PropertyAnimation(model, "translate.x", offsetX, offsetX+distance, 4000);
//        var carRidingFrontRotation = new AR.PropertyAnimation(model, "rotate.z",0 ,0, 4000);
     //   var carRiding= new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [carRidingFront, carRidingFrontRotation]);
        // var carTurningRightRotation = new AR.PropertyAnimation(model, "rotate.z", -90, 0, 3000);
        // var carTurningRightTranslationY = new AR.PropertyAnimation(model, "translate.y", offsetY-0.5, offsetY-0.5, 3000);
        // var carTurningRightTranslationX = new AR.PropertyAnimation(model, "translate.x", offsetX, offsetX, 3000);
        // var carTurningRight =  new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [carTurningRightRotation, carTurningRightTranslationX, carTurningRightTranslationY]);
        // var carWaiting = new AR.PropertyAnimation(model, "rotate.z", 0, 0, 2000);
        // var carRidingRight = new AR.PropertyAnimation(model, "translate.x", offsetX, offsetX +3, 4000);
         var animationGroup = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [carRidingFront]);
        animationGroup.start(-1);
      }
      

    }

    else if(page=== "page3"){  
        var rotateToLeft = new AR.PropertyAnimation(model, "rotate.z", null , 45 , 2000);
        var walking = new AR.PropertyAnimation(model, "translate.x", offsetX, offsetX+1.5, 2000);
        var animationGroupStart = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [rotateToLeft, walking]);
        var walking2 = new AR.PropertyAnimation(model, "translate.x", offsetX+1.5, offsetX+4, 2000)
        var animationGroup = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [animationGroupStart, walking2]);
        animationGroup.start(-1);
    }

    else if(page ==="page4"){
      if(item ==="nijntje"){
        var nijntjerotateToLeftrotation = new AR.PropertyAnimation(model, "rotate.z", null , 180 , 2000);
        var nijntjerotateToLefTranslationX = new AR.PropertyAnimation(model, "translate.x", offsetX, offsetX, 2000);
        var nijntjerotateToLefTranslationY = new AR.PropertyAnimation(model, "translate.y", offsetY, offsetY-1, 2000);
        var nijntjerotateToLeft = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.PARALLEL, [nijntjerotateToLeftrotation, nijntjerotateToLefTranslationX, nijntjerotateToLefTranslationY]);        var walking = new AR.PropertyAnimation(model, "translate.x", offsetX, offsetX-1.75, 3000);
        var rotateToRight = new AR.PropertyAnimation(model, "rotate.z", null , 45 , 2000);
        var walking2 = new AR.PropertyAnimation(model, "translate.x", offsetX-1.75, -0.3, 3000);
        var animationGroup = new AR.AnimationGroup(AR.CONST.ANIMATION_GROUP_TYPE.SEQUENTIAL, [nijntjerotateToLeft, walking, rotateToRight, walking2]);
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
