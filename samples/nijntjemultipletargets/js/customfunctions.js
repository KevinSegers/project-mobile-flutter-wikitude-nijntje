async function getItems(pageNumber, edgeService){
    let number = pageNumber.substring(4);
    const options = {
      method: 'GET', 
      headers: {'Content-Type': 'application/json' },
    };

    try{
        var result;
        const response = await fetch('http://'+edgeService+'/interactivebooks/booktitle/Nijntje in de speeltuin/pagenumber/'+number+'/items', options);
        if(!response.ok){
            throw new Error('Http error:'+response.status);
        }
        const data = await response.json();
        console.log(data);
        return result;

    }
    catch(error){
        console.error(error);
    }
  
}




  
async function setSeen( pageNumber, edgeService){
    let number = pageNumber.substring(4);
    const options = {
      method: 'PUT', 
      headers: {'Content-Type': 'application/json' },
    };

    try{
        const response = await fetch('http://'+edgeService+'/interactivebooks/pages/booktitle/Nijntje in de speeltuin/pagenumber/'+number, options);
        if(!response.ok){
            throw new Error('Http error:'+response.status);
        }
        const data = await response.json();

    }
    catch(error){
        console.error(error)
    }

}

function settingsPerItem () {
    return {
        auto:{
          scale: 0.006,
          rotatex: 0,
          rotatey: 0,
          rotatez: 0,
          translatex: -3,
          translatey: -0.5, 
          translatez: -1
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
          scale: 0.01,
          rotatex: 0,
          rotatey: 0,
          rotatez: 0,
          translatex: -0.25,
          translatey: -0.5,
          translatez: -0.5
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
          translatex: -0.2,
          translatey: 0.2,
          translatez: 0
        }, 
        
        klimboom:{
          scale: 0.02,
          rotatex: 0,
          rotatey: 0,
          rotatez: 180,
          translatex: -0.1,
          translatey: 1, 
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
    
      }
}