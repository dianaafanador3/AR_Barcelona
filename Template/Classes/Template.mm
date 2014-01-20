//
//  Template.m
//
// Copyright 2007-2013 metaio GmbH. All rights reserved.
//

#import "Template.h"
#import "EAGLView.h"

@implementation Template

// gesture masks to specify which gesture(s) is enabled
//int GESTURE_DRAG = 1<<0;
//int GESTURE_ROTATE = 2<<0;
//int GESTURE_PINCH = 4<<0;
//int GESTURE_ALL = 0xFF;


#pragma mark - UIViewController lifecycle

- (void)dealloc
{
    [super dealloc];
}


- (void) viewDidLoad
{
    [super viewDidLoad];
    
    if( !m_metaioSDK )
    {
        NSLog(@"SDK instance is 0x0. Please check the license string");
        return;
    }
    
    m_metaioSDK->setAmbientLight(metaio::Vector3d(0.05f));
    m_gestures = 0xFF; //enables all gestures
    m_gestureHandler = [[GestureHandlerIOS alloc] initWithSDK:m_metaioSDK withView:glView withGestures:m_gestures];
    
    DirectionalLightEnable = false;
    PointLightEnable = false;
    SpotLightEnable = false;
    
    
    

    
    trackingConfigFile = [[NSBundle mainBundle] pathForResource:@"TrackingData_Marker"
                                                         ofType:@"xml"
                                                    inDirectory:@"Assets"];
    
    if(trackingConfigFile)
	{
		bool success = m_metaioSDK->setTrackingConfiguration([trackingConfigFile UTF8String]);
		if( !success)
			NSLog(@"No success loading the tracking configuration");
	}
    
    
    NSString* modelPath = [[NSBundle mainBundle] pathForResource:@"arc"
                                                          ofType:@"obj"
                                                     inDirectory:@"Assets"];
    
    if (modelPath)
    {
        m_arc = m_metaioSDK->createGeometry([modelPath UTF8String]);
        if (m_arc)
        {
            m_arc->setScale(metaio::Vector3d(2.0, 2.0, 2.0));
            m_arc->setRotation(metaio::Rotation(metaio::Vector3d(M_PI_2, 0, 2.40)));
            [m_gestureHandler addObject:m_arc andGroup:1];
        }
        else
        {
            NSLog(@"Error: could not load model");
        }
    }
    
    NSString* modelPath2 = [[NSBundle mainBundle] pathForResource:@"campnou"
                                                           ofType:@"obj"
                                                      inDirectory:@"Assets"];
    
    if (modelPath2)
    {
        m_campnou = m_metaioSDK->createGeometry([modelPath2 UTF8String]);
        if (m_campnou)
        {
            m_campnou->setScale(metaio::Vector3d(0.6, 0.6, 0.6));
            m_campnou->setRotation(metaio::Rotation(metaio::Vector3d(M_PI_2, 0, 2.6)));
            [m_gestureHandler addObject:m_campnou andGroup:2];
        }
        else
        {
            NSLog(@"Error: could not load model");
        }
    }
    
    NSString* modelPath3 = [[NSBundle mainBundle] pathForResource:@"agbar"
                                                           ofType:@"obj"
                                                      inDirectory:@"Assets"];
    
    if (modelPath3)
    {
        m_agbar = m_metaioSDK->createGeometry([modelPath3 UTF8String]);
        if (m_agbar)
        {
            m_agbar->setScale(metaio::Vector3d(0.7, 0.7, 0.7));
            m_agbar->setRotation(metaio::Rotation(metaio::Vector3d(M_PI_2, 0, 2.4)));
            [m_gestureHandler addObject:m_agbar andGroup:3];
        }
        else
        {
            NSLog(@"Error: could not load model");
        }
    }
    
    NSString* modelPath4 = [[NSBundle mainBundle] pathForResource:@"mnac"
                                                           ofType:@"obj"
                                                      inDirectory:@"Assets"];
    
    if (modelPath4)
    {
        m_mnac = m_metaioSDK->createGeometry([modelPath4 UTF8String]);
        if (m_mnac)
        {
            m_mnac->setScale(metaio::Vector3d(0.8, 0.8, 0.8));
            m_mnac->setRotation(metaio::Rotation(metaio::Vector3d(M_PI_2, 0, 2.6)));
            [m_gestureHandler addObject:m_mnac andGroup:4];
        }
        else
        {
            NSLog(@"Error: could not load model");
        }
    }
    
    NSString* modelPath5 = [[NSBundle mainBundle] pathForResource:@"pedrera"
                                                           ofType:@"obj"
                                                      inDirectory:@"Assets"];
    
    if (modelPath5)
    {
        m_pedrera = m_metaioSDK->createGeometry([modelPath5 UTF8String]);
        if (m_pedrera)
        {
            m_pedrera->setScale(metaio::Vector3d(0.03, 0.03, 0.03));
            m_pedrera->setRotation(metaio::Rotation(metaio::Vector3d(M_PI_2, 0, 2.4)));
            [m_gestureHandler addObject:m_pedrera andGroup:5];
        }
        else
        {
            NSLog(@"Error: could not load model");
        }
    }
    
    NSString* modelPath6 = [[NSBundle mainBundle] pathForResource:@"sagradafamilia"
                                                           ofType:@"obj"
                                                      inDirectory:@"Assets"];
    
    if (modelPath6)
    {
        m_sagradafamilia = m_metaioSDK->createGeometry([modelPath6 UTF8String]);
        if (m_sagradafamilia)
        {
            m_sagradafamilia->setScale(metaio::Vector3d(0.5, 0.5, 0.5));
            m_sagradafamilia->setRotation(metaio::Rotation(metaio::Vector3d(M_PI_2, 0, 2.4)));
            [m_gestureHandler addObject:m_sagradafamilia andGroup:6];
        }
        else
        {
            NSLog(@"Error: could not load model");
        }
    }
    
    
    arcImage = [self getBillboardImageForTitle:@"Arco del Triunfo - Dirección: Passeig de Lluís Companys, 08010 Barcelona, Spain"];
    arcBillboard = m_metaioSDK->createGeometryFromCGImage("Arc", [arcImage CGImage], true);
    
    campnouImage = [self getBillboardImageForTitle:@"Camp Nou - Dirección: Carrer d'Aristides Maillol, 12, 08028 Barcelona, Spain"];
    campnouBillboard = m_metaioSDK->createGeometryFromCGImage("CampNou", [campnouImage CGImage], true);
    
    agbarImage = [self getBillboardImageForTitle:@"agbarital de Sant Pau - Dirección: Carrer Sant Quintí, 89, 08026 Barcelona, Spain"];
    agbarBillboard = m_metaioSDK->createGeometryFromCGImage("agbar", [agbarImage CGImage], true);
    
    mnacImage = [self getBillboardImageForTitle:@"MNAC - Dirección: Palau Nacional, Parc de Montjuïc, s/n, 08038 Barcelona, Spain"];
    mnacBillboard = m_metaioSDK->createGeometryFromCGImage("Mnac", [mnacImage CGImage], true);
    
    pedreraImage = [self getBillboardImageForTitle:@"La Pedrera - Dirección: Provença, 261-265, 08008 Barcelona, Spain"];
    pedreraBillboard = m_metaioSDK->createGeometryFromCGImage("Pedrera", [pedreraImage CGImage], true);
    
    sagradafamiliaImage = [self getBillboardImageForTitle:@"Sagrada Familia - Dirección: Carrer de Mallorca, 401, 08013 Barcelona, Spain"];
    sagradafamiliaBillboard = m_metaioSDK->createGeometryFromCGImage("SagradaFamilia", [sagradafamiliaImage CGImage], true);
    
    m_pDirectionalLight = m_metaioSDK->createLight();
    m_pDirectionalLight->setType(metaio::ELIGHT_TYPE_DIRECTIONAL);
    m_pDirectionalLight->setAmbientColor(metaio::Vector3d(0.4f, 0.4f, 0.4f));
    m_pDirectionalLight->setDiffuseColor(metaio::Vector3d(1.0f, 0.0f, 0.0f));
    m_pDirectionalLight->setCoordinateSystemID(1);
    
    m_pDirectionalLightGeo = [self createLightGeometry];
    m_pDirectionalLightGeo->setCoordinateSystemID(m_pDirectionalLight->getCoordinateSystemID());
    m_pDirectionalLightGeo->setTranslation(metaio::Vector3d(0.0, 0.0, 0.0));
    m_pDirectionalLightGeo->setDynamicLightingEnabled(false);
    
    
    
    
    m_pPointLight = m_metaioSDK->createLight();
    m_pPointLight->setType(metaio::ELIGHT_TYPE_POINT);
    m_pPointLight->setAmbientColor(metaio::Vector3d(0.4f, 0.4f, 0.4f));
    m_pPointLight->setAttenuation(metaio::Vector3d(0, 0, 40));
    m_pPointLight->setDiffuseColor(metaio::Vector3d(0.0f, 1.0f, 0.0f));
    m_pPointLight->setCoordinateSystemID(1);
    
    m_pPointLightGeo = [self createLightGeometry];
    m_pPointLightGeo->setCoordinateSystemID(m_pPointLight->getCoordinateSystemID());
    m_pPointLightGeo->setTranslation(metaio::Vector3d(0.0, 0.0, 0.0));
    m_pPointLightGeo->setDynamicLightingEnabled(false);
    
    
    
    m_pSpotLight = m_metaioSDK->createLight();
    m_pSpotLight->setAmbientColor(metaio::Vector3d(0.4f, 0.4f, 0.4f));
    m_pSpotLight->setType(metaio::ELIGHT_TYPE_SPOT);
    m_pSpotLight->setRadiusDegrees(20);
    m_pSpotLight->setDiffuseColor(metaio::Vector3d(0.0f, 0.0f, 1.0f));
    m_pSpotLight->setCoordinateSystemID(1);
    
    m_pSpotLightGeo = [self createLightGeometry];
    m_pSpotLightGeo->setCoordinateSystemID(m_pSpotLight->getCoordinateSystemID());
    m_pSpotLightGeo->setTranslation(metaio::Vector3d(0.0, 0.0, 0.0));
    m_pSpotLightGeo->setDynamicLightingEnabled(false);
    
}


- (metaio::IGeometry*)createLightGeometry
{
	NSString* filename = [[NSBundle mainBundle] pathForResource:@"sphere_10mm"
														 ofType:@"obj"
													inDirectory:@"Assets"];
    
	if (filename)
		return m_metaioSDK->createGeometry([filename UTF8String]);
	else
	{
		NSLog(@"Could not find 3D model to use as light indicator");
		return 0;
	}
}



- (UIImage*) getBillboardImageForTitle: (NSString*) title
{
   
    // first lets find out if we're drawing retina resolution or not
    float scaleFactor = [UIScreen mainScreen].scale;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        scaleFactor = 2;        // draw in high-res for iPad
    
    // then lets draw
    UIImage* bgImage = nil;
    NSString* imagePath;
    if( scaleFactor == 1 )	// potentially this is not necessary anyway, because iOS automatically picks 2x version for iPhone4
    {
        
        imagePath = [[NSBundle mainBundle] pathForResource:@"POI_bg"
													ofType:@"png"
											   inDirectory:@"Assets"];
    }
    else
    {
        imagePath = [[NSBundle mainBundle] pathForResource:@"POI_bg@2x"
													ofType:@"png"
											   inDirectory:@"Assets"];

    }
    
    bgImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    UIGraphicsBeginImageContext( bgImage.size );			// create a new image context
    CGContextRef currContext = UIGraphicsGetCurrentContext();
    
    // mirror the context transformation to draw the images correctly
    CGContextTranslateCTM( currContext, 0, bgImage.size.height );
    CGContextScaleCTM(currContext, 1.0, -1.0);
    CGContextDrawImage(currContext,  CGRectMake(0, 0, bgImage.size.width, bgImage.size.height), [bgImage CGImage]);
    
    // now bring the context transformation back to what it was before
    CGContextScaleCTM(currContext, 1.0, -1.0);
    CGContextTranslateCTM( currContext, 0, -bgImage.size.height );
    
    // and add some text...
    CGContextSetRGBFillColor(currContext, 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextSetTextDrawingMode(currContext, kCGTextFill);
    CGContextSetShouldAntialias(currContext, true);
    
    // draw the heading
    float border = title.length*scaleFactor;
    [title drawInRect:CGRectMake(5, 5,
                                 bgImage.size.width - 5,
                                 bgImage.size.height - 5)
             withFont:[UIFont systemFontOfSize:4 * scaleFactor]];
    
    // retrieve the screenshot from the current context
    UIImage* blendetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return blendetImage;
}


#pragma mark - @protocol metaioSDKDelegate

- (void) onSDKReady
{
    NSLog(@"The SDK is ready");
}

- (void) onAnimationEnd: (metaio::IGeometry*) geometry  andName:(NSString*) animationName
{
	 NSLog(@"animation ended %@", animationName);
}


- (void) onMovieEnd: (metaio::IGeometry*) geometry  andName:(NSString*) movieName
{
	NSLog(@"movie ended %@", movieName);
	
}

- (void) onNewCameraFrame:(metaio::ImageStruct *)cameraFrame
{
    NSLog(@"a new camera frame image is delivered %f", cameraFrame->timestamp);
}

- (void) onCameraImageSaved:(NSString *)filepath
{
    NSLog(@"a new camera frame image is saved to %@", filepath);
}

-(void) onScreenshotImage:(metaio::ImageStruct *)image
{
    
    NSLog(@"screenshot image is received %f", image->timestamp);
}

- (void) onScreenshotImageIOS:(UIImage *)image
{
    NSLog(@"screenshot image is received %@", [image description]);
}

-(void) onScreenshot:(NSString *)filepath
{
    NSLog(@"screenshot is saved to %@", filepath);
}

- (void) onTrackingEvent:(const metaio::stlcompat::Vector<metaio::TrackingValues>&)trackingValues
{
    NSLog(@"The tracking time is: %f", trackingValues[0].timeElapsed);
    
}

- (void) onInstantTrackingEvent:(bool)success file:(NSString*)file
{
    if (success)
    {
        NSLog(@"Instant 3D tracking is successful");
    }
}

- (void) onVisualSearchResult:(bool)success error:(NSString *)errorMsg response:(std::vector<metaio::VisualSearchResponse>)response
{
    if (success)
    {
        NSLog(@"Visual search is successful");
    }
}

- (void) onVisualSearchStatusChanged:(metaio::EVISUAL_SEARCH_STATE)state
{
    if (state == metaio::EVSS_SERVER_COMMUNICATION)
    {
        NSLog(@"Visual search is currently communicating with the server");
    }
}

#pragma mark - Handling Touches

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // record the initial states of the geometries with the gesture handler
    [m_gestureHandler touchesBegan:touches withEvent:event withView:glView];
    
    // Here's how to pick a geometry
	UITouch *touch = [touches anyObject];
	CGPoint loc = [touch locationInView:glView];
	
    /*
    // get the scale factor (will be 2 for retina screens)
    float scale = glView.contentScaleFactor;
    
    
    // Lights circle around
    const float time = (float)CACurrentMediaTime();
    const metaio::Vector3d lightPos(200*cosf(time), 120*sinf(0.25f*time), 200*sinf(time));
    
    const float FREQ2MUL = 0.4f;
    const metaio::Vector3d lightPos2(150*cosf(FREQ2MUL*2.2f*time) * (1 + 2+2*sinf(FREQ2MUL*0.6f*time)), 30*sinf(FREQ2MUL*0.35f*time), 150*sinf(FREQ2MUL*2.2f*time));
    
    const metaio::Vector3d directionalLightDir(cosf(1.2f*time), sinf(0.25f*time), sinf(0.8f*time));
    

	metaio::IGeometry* model = m_metaioSDK->getGeometryFromScreenCoordinates(loc.x * scale, loc.y * scale, false);
	
    
    if (model == m_arc)
	{
		m_pSpotLight->setCoordinateSystemID(7);
        // Spot light
        m_pSpotLight->setTranslation(lightPos2);
        m_pSpotLight->setDirection(-lightPos2); // spot towards origin of COS
        [self updateLightIndicator:m_pSpotLightGeo light:m_pSpotLight];
        
        
	}
    else if (model == m_campnou)
    {
        m_pDirectionalLight->setCoordinateSystemID(2);
        // Directional light
        m_pDirectionalLight->setDirection(directionalLightDir);
        [self updateLightIndicator:m_pDirectionalLightGeo light:m_pDirectionalLight];
    }
    else if (model == m_mnac)
    {
        NSLog(@"mnaccccccccccc");
        m_pPointLight->setCoordinateSystemID(3);
        // Point light
        m_pPointLight->setTranslation(lightPos);
        [self updateLightIndicator:m_pPointLightGeo light:m_pPointLight];
    }
    else if(model == m_pedrera)
    {
        m_pSpotLight->setCoordinateSystemID(4);
        // Spot light
        m_pSpotLight->setTranslation(lightPos2);
        m_pSpotLight->setDirection(-lightPos2); // spot towards origin of COS
        [self updateLightIndicator:m_pSpotLightGeo light:m_pSpotLight];
    }
    else if(model == m_agbar)
    {
        m_pDirectionalLight->setCoordinateSystemID(5);
        // Directional light
        m_pDirectionalLight->setDirection(directionalLightDir);
        [self updateLightIndicator:m_pDirectionalLightGeo light:m_pDirectionalLight];
    }
    else if (model == m_sagradafamilia)
    {
        m_pPointLight->setCoordinateSystemID(6);
        // Point light
        m_pPointLight->setTranslation(lightPos);
        [self updateLightIndicator:m_pPointLightGeo light:m_pPointLight];
    }*/

    
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    // handles the drag touch
    [m_gestureHandler touchesMoved:touches withEvent:event withView:glView];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [m_gestureHandler touchesEnded:touches withEvent:event withView:glView];
}


- (void)drawFrame
{
    [super drawFrame];
    
    // return if the metaio SDK has not been initialiyed yet
    if( !m_metaioSDK )
        return;
    
    // get all the detected poses/targets
    std::vector<metaio::TrackingValues> poses = m_metaioSDK->getTrackingValues();
    
    
    // This will only apply in the upcoming frame:
    
    // Directional light
    
    
    
    
    //if we have detected one, attach our model to this coordinate system ID
    if(poses.size())
    {
        if (poses[0].coordinateSystemID == 7)
        {
            m_arc->setCoordinateSystemID( poses[0].coordinateSystemID );
            arcBillboard->setCoordinateSystemID( poses[0].coordinateSystemID );
            arcBillboard->setTranslation(metaio::Vector3d(0.0, 50.0, 80.0));
            arcBillboard->setScale(metaio::Vector3d(0.5, 0.5, 0.5));
            
        }
        else if (poses[0].coordinateSystemID == 2)
        {
            m_campnou->setCoordinateSystemID( poses[0].coordinateSystemID );
            campnouBillboard->setCoordinateSystemID( poses[0].coordinateSystemID );
            campnouBillboard->setTranslation(metaio::Vector3d(0.0, 50.0, 80.0));
            campnouBillboard->setScale(metaio::Vector3d(0.5, 0.5, 0.5));
            
            
            
        }
        else if (poses[0].coordinateSystemID == 3)
        {
            m_agbar->setCoordinateSystemID( poses[0].coordinateSystemID );
            agbarBillboard->setCoordinateSystemID( poses[0].coordinateSystemID );
            agbarBillboard->setTranslation(metaio::Vector3d(0.0, 50.0, 80.0));
            agbarBillboard->setScale(metaio::Vector3d(0.5, 0.5, 0.5));
            
        }
        else if (poses[0].coordinateSystemID == 4)
        {
            m_mnac->setCoordinateSystemID( poses[0].coordinateSystemID );
            mnacBillboard->setCoordinateSystemID( poses[0].coordinateSystemID );
            mnacBillboard->setTranslation(metaio::Vector3d(0.0, 50.0, 80.0));
            mnacBillboard->setScale(metaio::Vector3d(0.5, 0.5, 0.5));
            
        }
        else if (poses[0].coordinateSystemID == 5)
        {
            m_pedrera->setCoordinateSystemID( poses[0].coordinateSystemID );
            pedreraBillboard->setCoordinateSystemID( poses[0].coordinateSystemID );
            pedreraBillboard->setTranslation(metaio::Vector3d(0.0, 50.0, 80.0));
            pedreraBillboard->setScale(metaio::Vector3d(0.5, 0.5, 0.5));
           
        }
        else if (poses[0].coordinateSystemID == 6)
        {
            m_sagradafamilia->setCoordinateSystemID( poses[0].coordinateSystemID );
            sagradafamiliaBillboard->setCoordinateSystemID( poses[0].coordinateSystemID );
            sagradafamiliaBillboard->setTranslation(metaio::Vector3d(0.0, 50.0, 80.0));
            sagradafamiliaBillboard->setScale(metaio::Vector3d(0.5, 0.5, 0.5));
            
        }
    }
    
    
    const float time = (float)CACurrentMediaTime();
    const metaio::Vector3d lightPos(80*cosf(time), 30*sinf(0.25f*time), 80*sinf(time));
    
    const metaio::Vector3d directionalLightDir(cosf(1.2f*time), sinf(0.25f*time), sinf(0.8f*time));
    
    const float FREQ2MUL = 0.4f;
    const metaio::Vector3d lightPos2(50*cosf(FREQ2MUL*2.2f*time) * (1 + 2+2*sinf(FREQ2MUL*0.6f*time)), 50*sinf(FREQ2MUL*0.35f*time), 50*sinf(FREQ2MUL*2.2f*time));
    
    
    // Directional light
    m_pDirectionalLight->setDirection(directionalLightDir);
    [self updateLightIndicator:m_pDirectionalLightGeo light:m_pDirectionalLight];
    
    // Point light
    m_pPointLight->setTranslation(lightPos);
    [self updateLightIndicator:m_pPointLightGeo light:m_pPointLight];
    
    // Spot light
    m_pSpotLight->setTranslation(lightPos2);
    m_pSpotLight->setDirection(-lightPos2); // spot towards origin of COS
    [self updateLightIndicator:m_pSpotLightGeo light:m_pSpotLight];
}



- (void)updateLightIndicator:(metaio::IGeometry*)indicatorGeo light:(metaio::ILight*)light
{
	indicatorGeo->setVisible(light->isEnabled());
    
	if (!light->isEnabled())
		return;
    
	if (light->getType() == metaio::ELIGHT_TYPE_DIRECTIONAL)
	{
		metaio::Vector3d dir = light->getDirection();
		dir /= dir.norm();
        
		// Indicate "source" of directional light (not really the source because it's infinite)
		indicatorGeo->setTranslation(metaio::Vector3d(-200.0f * dir.x, -200.0f * dir.y, -200.0f * dir.z));
	}
	else
		indicatorGeo->setTranslation(light->getTranslation());
}


- (IBAction)onArcClick:(id)sender
{
    
        
        // reset the location of the geometry
        CGRect screen = self.view.bounds;
        CGFloat width = screen.size.width * [UIScreen mainScreen].scale;
        CGFloat height = screen.size.height * [UIScreen mainScreen].scale;
        metaio::Vector3d translation = m_metaioSDK->get3DPositionFromScreenCoordinates(1, metaio::Vector2d(width/2, height/2));
        
        m_arc->setTranslation(translation);
        //arcBillboard->setTranslation(translation);
		
        // reset the scale of the geometry
        
        m_arc->setScale(metaio::Vector3d(50.0, 50.0, 50.0));
    
}

- (IBAction)onCampNouClick:(id)sender
{
    
        
        CGRect screen = self.view.bounds;
        CGFloat width = screen.size.width * [UIScreen mainScreen].scale;
        CGFloat height = screen.size.height * [UIScreen mainScreen].scale;
        metaio::Vector3d translation = m_metaioSDK->get3DPositionFromScreenCoordinates(1, metaio::Vector2d(width/2, height/2));
        
        
        m_campnou->setTranslation(translation);
        m_campnou->setScale(metaio::Vector3d(50.0, 50.0, 50.0));
    
}

- (IBAction)onAgbarClick:(id)sender
{
        CGRect screen = self.view.bounds;
        CGFloat width = screen.size.width * [UIScreen mainScreen].scale;
        CGFloat height = screen.size.height * [UIScreen mainScreen].scale;
        metaio::Vector3d translation = m_metaioSDK->get3DPositionFromScreenCoordinates(1, metaio::Vector2d(width/2, height/2));
        
        m_agbar->setTranslation(translation);
        m_agbar->setScale(metaio::Vector3d(5.0, 5.0, 5.0));
    
}

- (IBAction)onMnacClick:(id)sender
{
    
        // reset the location of the geometry
        CGRect screen = self.view.bounds;
        CGFloat width = screen.size.width * [UIScreen mainScreen].scale;
        CGFloat height = screen.size.height * [UIScreen mainScreen].scale;
        metaio::Vector3d translation = m_metaioSDK->get3DPositionFromScreenCoordinates(1, metaio::Vector2d(width/2, height/2));
        m_mnac->setTranslation(translation);
        
        // reset the scale of the geometry
        m_mnac->setScale(metaio::Vector3d(50.0, 50.0, 50.0));
    
}

- (IBAction)onPedreraClick:(id)sender
{
    
        CGRect screen = self.view.bounds;
        CGFloat width = screen.size.width * [UIScreen mainScreen].scale;
        CGFloat height = screen.size.height * [UIScreen mainScreen].scale;
        metaio::Vector3d translation = m_metaioSDK->get3DPositionFromScreenCoordinates(1, metaio::Vector2d(width/2, height/2));
        
        
        m_pedrera->setTranslation(translation);
        m_pedrera->setScale(metaio::Vector3d(50.0, 50.0, 50.0));
    
}

- (IBAction)onSagradaFamiliaClick:(id)sender
{
    
        
        CGRect screen = self.view.bounds;
        CGFloat width = screen.size.width * [UIScreen mainScreen].scale;
        CGFloat height = screen.size.height * [UIScreen mainScreen].scale;
        metaio::Vector3d translation = m_metaioSDK->get3DPositionFromScreenCoordinates(1, metaio::Vector2d(width/2, height/2));
        
        m_sagradafamilia->setTranslation(translation);
        m_sagradafamilia->setScale(metaio::Vector3d(5.0, 5.0, 5.0));
    
}


- (IBAction)OnDirectionalClick:(id)sender
{
    if (!DirectionalLightEnable)
    {
        NSLog(@"true");
        std::vector<metaio::TrackingValues> poses = m_metaioSDK->getTrackingValues();
        m_pDirectionalLight->setCoordinateSystemID(poses[0].coordinateSystemID);
        m_pDirectionalLightGeo->setCoordinateSystemID(m_pDirectionalLight->getCoordinateSystemID());
        DirectionalLightEnable = true;
    }
    else if(DirectionalLightEnable)
    {
        NSLog(@"false");
        m_pDirectionalLight->setCoordinateSystemID(1);
        m_pDirectionalLightGeo->setCoordinateSystemID(m_pDirectionalLight->getCoordinateSystemID());
        DirectionalLightEnable = false;
    }
}

- (IBAction)OnPointLightClick:(id)sender
{
    if (!PointLightEnable)
    {
        std::vector<metaio::TrackingValues> poses = m_metaioSDK->getTrackingValues();
        m_pPointLight->setCoordinateSystemID(poses[0].coordinateSystemID);
        m_pPointLightGeo->setCoordinateSystemID(m_pPointLight->getCoordinateSystemID());
        PointLightEnable = true;
    }
    else if(PointLightEnable)
    {
        m_pPointLight->setCoordinateSystemID(1);
        m_pPointLightGeo->setCoordinateSystemID(m_pPointLight->getCoordinateSystemID());
        PointLightEnable = false;
    }
}

- (IBAction)OnSpotLightClick:(id)sender
{
    if (!SpotLightEnable)
    {
        std::vector<metaio::TrackingValues> poses = m_metaioSDK->getTrackingValues();
        m_pSpotLight->setCoordinateSystemID(poses[0].coordinateSystemID);
        m_pSpotLightGeo->setCoordinateSystemID(m_pSpotLight->getCoordinateSystemID());
        SpotLightEnable = true;
    }
    else if(SpotLightEnable)
    {
        m_pSpotLight->setCoordinateSystemID(1);
        m_pSpotLightGeo->setCoordinateSystemID(m_pSpotLight->getCoordinateSystemID());
        SpotLightEnable = false;
    }
}


- (IBAction)OnReset:(id)sender
{
    m_pDirectionalLight->setCoordinateSystemID(1);
    m_pDirectionalLightGeo->setCoordinateSystemID(m_pDirectionalLight->getCoordinateSystemID());
    m_pPointLight->setCoordinateSystemID(1);
    m_pPointLightGeo->setCoordinateSystemID(m_pPointLight->getCoordinateSystemID());
    m_pSpotLight->setCoordinateSystemID(1);
    m_pSpotLightGeo->setCoordinateSystemID(m_pSpotLight->getCoordinateSystemID());
    DirectionalLightEnable = false;
    PointLightEnable = false;
    SpotLightEnable = false;
}

@end
