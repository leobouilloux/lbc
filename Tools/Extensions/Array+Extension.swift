//
//  Array+Extension.swift
//  LBC
//
//  Created by Leo Marcotte on 30/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
