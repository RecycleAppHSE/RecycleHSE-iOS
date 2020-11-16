//
//  ResultCallback.swift
//  Recycle
//
//  Created by Babaev Mikhail on 02.11.2020.
//

import Foundation

typealias ResultCallback<T> = ((Result<T, Error>) -> Void)
