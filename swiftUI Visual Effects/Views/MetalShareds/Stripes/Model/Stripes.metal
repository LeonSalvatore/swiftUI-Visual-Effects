//
//  Stripes.metal
//  swiftUI Visual Effects
//
//  Created by Leon Salvatore on 02.05.2025.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

[[ stitchable ]]
half4 Stripes(
    float2 position,
    float thickness,
    device const half4 *ptr,
    int count
) {
    int i = int(floor(position.y / thickness));

    // Clamp to 0 ..< count.
    i = ((i % count) + count) % count;

    return ptr[i];
}

