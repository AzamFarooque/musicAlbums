//
//  ViewController.swift
//  musicAlbums
//
//  Created by Farooque on 08/11/17.
//  Copyright © 2017 Farooque. All rights reserved.
//

import Foundation


internal func Init<Type>(_ value : Type, block: (_ object: Type) -> Void) -> Type
{
  block(value)
  return value
}
