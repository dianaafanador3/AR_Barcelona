//
//  Template.h
//
//  Copyright 2007-2013 metaio GmbH. All rights reserved.
//

#import "MetaioSDKViewController.h"
#import <metaioSDK/GestureHandlerIOS.h>

@interface Template : MetaioSDKViewController
{	
    metaio::IGeometry*	m_arc;
    metaio::IGeometry*	m_campnou;
    metaio::IGeometry*	m_agbar;
    metaio::IGeometry*	m_mnac;
    metaio::IGeometry*	m_pedrera;
    metaio::IGeometry*	m_sagradafamilia;
    NSString *trackingConfigFile;
    
    // GestureHandler handles the dragging/pinch/rotation touches
    GestureHandlerIOS* m_gestureHandler;
    //gesture mask to specify the gestures that are enabled
    int m_gestures;
	// remember the TrackingValues
	metaio::TrackingValues m_pose;
    
    metaio::IGeometry* arcBillboard;
    metaio::IGeometry* campnouBillboard;
    metaio::IGeometry* agbarBillboard;
    metaio::IGeometry* mnacBillboard;
    metaio::IGeometry* pedreraBillboard;
    metaio::IGeometry* sagradafamiliaBillboard;
    
    metaio::ILight* m_pDirectionalLight;
    metaio::IGeometry* m_pDirectionalLightGeo;
    
    metaio::ILight* m_pPointLight;
    metaio::IGeometry* m_pPointLightGeo;
    
    metaio::ILight* m_pSpotLight;
    metaio::IGeometry* m_pSpotLightGeo;
    
    UIImage* arcImage;
    UIImage* campnouImage;
    UIImage* agbarImage;
    UIImage* mnacImage;
    UIImage* pedreraImage;
    UIImage* sagradafamiliaImage;
    
    bool DirectionalLightEnable;
    bool PointLightEnable;
    bool SpotLightEnable;

    

}

- (IBAction)onArcClick:(id)sender;
- (IBAction)onCampNouClick:(id)sender;
- (IBAction)onAgbarClick:(id)sender;
- (IBAction)onMnacClick:(id)sender;
- (IBAction)onPedreraClick:(id)sender;
- (IBAction)onSagradaFamiliaClick:(id)sender;


- (IBAction)OnDirectionalClick:(id)sender;
- (IBAction)OnPointLightClick:(id)sender;
- (IBAction)OnSpotLightClick:(id)sender;
- (IBAction)OnReset:(id)sender;

@end

