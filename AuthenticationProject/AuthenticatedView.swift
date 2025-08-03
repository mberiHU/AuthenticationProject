//
//  AuthenticatedView.swift
//  AuthenticationProject
//
//  Created by Maahin Beri on 6/13/25.
//

import SwiftUI

struct AuthenticatedView: View {

    var body: some View {
        ZStack {
            
            Image(.topSecret)
                .scaledToFit()
            
            Text("Here lies the treasure")
                .frame(maxWidth: .infinity, alignment:.center)
                .font(.system(size: 36))
                .minimumScaleFactor(0.8)
        }
    }
}
