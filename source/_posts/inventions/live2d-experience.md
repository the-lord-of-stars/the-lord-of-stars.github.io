---
title: Live2D Experience

date: 2025-03-11

categories:
  - project

tags:
- art

description: |
    This is my first time self-made live2d experience.
---

<script src="https://unpkg.com/oh-my-live2d@latest"></script>
<script>
  OML2D.loadOml2d({
   models: [{
        path: 'https://raw.githubusercontent.com/the-lord-of-stars/warehouse/main/model/duck_model/duck.model3.json',
        position: [0, 0],
        scale:0.12,
        stageStyle:{
            marginBottom: '10px',
            marginLeft: '15px',
            shadow: '0 0 10px rgba(0, 0, 0, 0.05)',
            borderRadius: '20px',
            backgroundColor: '#FFFFFF',
        },
   }],
   statusBar: {
        restMessage: 'Resting',
        loadSuccessMessage: 'Success'
   },
   tips: {
        style: {
               display: 'none',
               }
        },
   menus: {
        style: {
               marginRight: '20px',
        },
        items: [{
               id: 'Rest',
               icon: 'icon-rest',
               title: 'rest',
               onClick: (oml2d) => {
                                    oml2d.stageSlideOut();
                                    oml2d.setStatusBarClickEvent(
                                        () => {
                                            oml2d.stageSlideIn();
                                            oml2d.statusBarClose('Success');
                                        }
                                    );
                                    oml2d.statusBarOpen('Resting');}
               }]
        },
  });
</script>
