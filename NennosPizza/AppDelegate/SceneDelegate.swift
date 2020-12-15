//
//  SceneDelegate.swift
//  NennosPizza
//
//  Created by Arthur Jinian on 12/4/20.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate, HomeRoute {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        showHome(di: HomeDi(), window: window)
    }
}

