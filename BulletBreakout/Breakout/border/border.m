#import "border.h"

const GLKVector4 Border_Cube_Border_ambient = {0.000000, 0.000000, 0.000000, 1.000000};
const GLKVector4 Border_Cube_Border_diffuse = {0.186408, 0.186408, 0.186408, 1.000000};
const GLKVector4 Border_Cube_Border_specular = {0.500000, 0.500000, 0.500000, 1.000000};
const float Border_Cube_Border_shininess = 96.078430;

const Vertex Border_Cube_Border_Vertices[132] = {
    {{-13.499982, 24.000021, -0.500000}, {0.037837, 0.643721}, {0.000000, -0.000000, -1.000000}},
    {{-14.499978, 24.000021, -0.500000}, {0.037831, 0.638893}, {0.000000, -0.000000, -1.000000}},
    {{-14.499974, 25.000021, -0.500000}, {0.075749, 0.636898}, {0.000000, -0.000000, -1.000000}},
    {{-13.499982, 24.000021, -0.500000}, {0.037837, 0.643721}, {0.000000, -0.000000, -1.000000}},
    {{-14.499974, 25.000021, -0.500000}, {0.075749, 0.636898}, {0.000000, -0.000000, -1.000000}},
    {{-13.499981, 25.000021, -0.500000}, {0.075879, 0.641888}, {0.000000, -0.000000, -1.000000}},
    {{-13.499992, 24.000021, 0.500000}, {0.151662, 0.641736}, {-0.000000, 0.000000, 1.000000}},
    {{-13.499978, 25.000021, 0.500000}, {0.114197, 0.641768}, {-0.000000, 0.000000, 1.000000}},
    {{-14.499972, 25.000021, 0.500000}, {0.113956, 0.636899}, {-0.000000, 0.000000, 1.000000}},
    {{-13.499992, 24.000021, 0.500000}, {0.151662, 0.641736}, {-0.000000, 0.000000, 1.000000}},
    {{-14.499972, 25.000021, 0.500000}, {0.113956, 0.636899}, {-0.000000, 0.000000, 1.000000}},
    {{-14.499987, 24.000021, 0.500000}, {0.151424, 0.636915}, {-0.000000, 0.000000, 1.000000}},
    {{13.500014, 24.000002, -0.500000}, {0.000122, 0.253237}, {0.000000, -0.000000, -1.000000}},
    {{14.500008, 24.000002, -0.500000}, {0.008316, 0.190115}, {0.000000, -0.000000, -1.000000}},
    {{14.499976, -24.000021, -0.499999}, {0.500060, 0.190115}, {0.000000, -0.000000, -1.000000}},
    {{13.500014, 24.000002, -0.500000}, {0.000122, 0.253237}, {0.000000, -0.000000, -1.000000}},
    {{14.499976, -24.000021, -0.499999}, {0.500060, 0.190115}, {0.000000, -0.000000, -1.000000}},
    {{13.499983, -24.000021, -0.499999}, {0.491869, 0.253238}, {0.000000, -0.000000, -1.000000}},
    {{-14.499978, 24.000021, -0.500000}, {0.075749, 0.598691}, {-1.000000, 0.000009, -0.000003}},
    {{-14.499987, 24.000021, 0.500000}, {0.113956, 0.598691}, {-1.000000, 0.000009, -0.000003}},
    {{-14.499972, 25.000021, 0.500000}, {0.113956, 0.636899}, {-1.000000, 0.000009, -0.000003}},
    {{-14.499978, 24.000021, -0.500000}, {0.075749, 0.598691}, {-1.000000, 0.000009, -0.000003}},
    {{-14.499972, 25.000021, 0.500000}, {0.113956, 0.636899}, {-1.000000, 0.000009, -0.000003}},
    {{-14.499974, 25.000021, -0.500000}, {0.075749, 0.636898}, {-1.000000, 0.000009, -0.000003}},
    {{13.500021, 25.000002, -0.500000}, {0.076681, 0.676907}, {0.000000, 1.000000, 0.000000}},
    {{13.500016, 25.000002, 0.500000}, {0.114152, 0.676958}, {0.000000, 1.000000, 0.000000}},
    {{14.500010, 25.000002, 0.500000}, {0.114403, 0.681865}, {0.000000, 1.000000, 0.000000}},
    {{13.500021, 25.000002, -0.500000}, {0.076681, 0.676907}, {0.000000, 1.000000, 0.000000}},
    {{14.500010, 25.000002, 0.500000}, {0.114403, 0.681865}, {0.000000, 1.000000, 0.000000}},
    {{14.500014, 25.000002, -0.500000}, {0.076802, 0.681757}, {0.000000, 1.000000, 0.000000}},
    {{14.500001, 24.000002, 0.500000}, {0.114295, 0.719466}, {1.000000, -0.000008, 0.000006}},
    {{14.500008, 24.000002, -0.500000}, {0.076694, 0.719359}, {1.000000, -0.000008, 0.000006}},
    {{14.500014, 25.000002, -0.500000}, {0.076802, 0.681757}, {1.000000, -0.000008, 0.000006}},
    {{14.500001, 24.000002, 0.500000}, {0.114295, 0.719466}, {1.000000, -0.000008, 0.000006}},
    {{14.500014, 25.000002, -0.500000}, {0.076802, 0.681757}, {1.000000, -0.000008, 0.000006}},
    {{14.500010, 25.000002, 0.500000}, {0.114403, 0.681865}, {1.000000, -0.000008, 0.000006}},
    {{13.500014, 24.000002, -0.500000}, {0.039473, 0.678834}, {0.000000, -0.000000, -1.000000}},
    {{-13.499982, 24.000021, -0.500000}, {0.037837, 0.643721}, {0.000000, -0.000000, -1.000000}},
    {{-13.499981, 25.000021, -0.500000}, {0.075879, 0.641888}, {0.000000, -0.000000, -1.000000}},
    {{13.500014, 24.000002, -0.500000}, {0.039473, 0.678834}, {0.000000, -0.000000, -1.000000}},
    {{-13.499981, 25.000021, -0.500000}, {0.075879, 0.641888}, {0.000000, -0.000000, -1.000000}},
    {{13.500021, 25.000002, -0.500000}, {0.076681, 0.676907}, {0.000000, -0.000000, -1.000000}},
    {{13.500008, 24.000002, 0.500000}, {0.151796, 0.676692}, {-0.000000, 0.000000, 1.000000}},
    {{13.500016, 25.000002, 0.500000}, {0.114152, 0.676958}, {-0.000000, 0.000000, 1.000000}},
    {{-13.499978, 25.000021, 0.500000}, {0.114197, 0.641768}, {-0.000000, 0.000000, 1.000000}},
    {{13.500008, 24.000002, 0.500000}, {0.151796, 0.676692}, {-0.000000, 0.000000, 1.000000}},
    {{-13.499978, 25.000021, 0.500000}, {0.114197, 0.641768}, {-0.000000, 0.000000, 1.000000}},
    {{-13.499992, 24.000021, 0.500000}, {0.151662, 0.641736}, {-0.000000, 0.000000, 1.000000}},
    {{13.500014, 24.000002, -0.500000}, {0.039473, 0.678834}, {-0.000001, -1.000000, -0.000000}},
    {{13.500008, 24.000002, 0.500000}, {0.001759, 0.680592}, {-0.000001, -1.000000, -0.000000}},
    {{-13.499992, 24.000021, 0.500000}, {0.000122, 0.645479}, {-0.000001, -1.000000, -0.000000}},
    {{13.500014, 24.000002, -0.500000}, {0.039473, 0.678834}, {-0.000001, -1.000000, -0.000000}},
    {{-13.499992, 24.000021, 0.500000}, {0.000122, 0.645479}, {-0.000001, -1.000000, -0.000000}},
    {{-13.499982, 24.000021, -0.500000}, {0.037837, 0.643721}, {-0.000001, -1.000000, -0.000000}},
    {{-14.499974, 25.000021, -0.500000}, {0.075749, 0.636898}, {0.000000, 1.000000, 0.000000}},
    {{-14.499972, 25.000021, 0.500000}, {0.113956, 0.636899}, {0.000000, 1.000000, 0.000000}},
    {{-13.499978, 25.000021, 0.500000}, {0.114197, 0.641768}, {0.000000, 1.000000, 0.000000}},
    {{-14.499974, 25.000021, -0.500000}, {0.075749, 0.636898}, {0.000000, 1.000000, 0.000000}},
    {{-13.499978, 25.000021, 0.500000}, {0.114197, 0.641768}, {0.000000, 1.000000, 0.000000}},
    {{-13.499981, 25.000021, -0.500000}, {0.075879, 0.641888}, {0.000000, 1.000000, 0.000000}},
    {{-13.499981, 25.000021, -0.500000}, {0.075879, 0.641888}, {0.000001, 1.000000, 0.000000}},
    {{-13.499978, 25.000021, 0.500000}, {0.114197, 0.641768}, {0.000001, 1.000000, 0.000000}},
    {{13.500016, 25.000002, 0.500000}, {0.114152, 0.676958}, {0.000001, 1.000000, 0.000000}},
    {{-13.499981, 25.000021, -0.500000}, {0.075879, 0.641888}, {0.000001, 1.000000, 0.000000}},
    {{13.500016, 25.000002, 0.500000}, {0.114152, 0.676958}, {0.000001, 1.000000, 0.000000}},
    {{13.500021, 25.000002, -0.500000}, {0.076681, 0.676907}, {0.000001, 1.000000, 0.000000}},
    {{14.500008, 24.000002, -0.500000}, {0.039490, 0.683715}, {0.000000, -0.000000, -1.000000}},
    {{13.500014, 24.000002, -0.500000}, {0.039473, 0.678834}, {0.000000, -0.000000, -1.000000}},
    {{13.500021, 25.000002, -0.500000}, {0.076681, 0.676907}, {0.000000, -0.000000, -1.000000}},
    {{14.500008, 24.000002, -0.500000}, {0.039490, 0.683715}, {0.000000, -0.000000, -1.000000}},
    {{13.500021, 25.000002, -0.500000}, {0.076681, 0.676907}, {0.000000, -0.000000, -1.000000}},
    {{14.500014, 25.000002, -0.500000}, {0.076802, 0.681757}, {0.000000, -0.000000, -1.000000}},
    {{14.500001, 24.000002, 0.500000}, {0.152071, 0.681604}, {-0.000000, 0.000000, 1.000000}},
    {{14.500010, 25.000002, 0.500000}, {0.114403, 0.681865}, {-0.000000, 0.000000, 1.000000}},
    {{13.500016, 25.000002, 0.500000}, {0.114152, 0.676958}, {-0.000000, 0.000000, 1.000000}},
    {{14.500001, 24.000002, 0.500000}, {0.152071, 0.681604}, {-0.000000, 0.000000, 1.000000}},
    {{13.500016, 25.000002, 0.500000}, {0.114152, 0.676958}, {-0.000000, 0.000000, 1.000000}},
    {{13.500008, 24.000002, 0.500000}, {0.151796, 0.676692}, {-0.000000, 0.000000, 1.000000}},
    {{14.500008, 24.000002, -0.500000}, {0.008316, 0.190115}, {1.000000, -0.000001, 0.000007}},
    {{14.500001, 24.000002, 0.500000}, {0.015276, 0.126679}, {1.000000, -0.000001, 0.000007}},
    {{14.499969, -24.000021, 0.500001}, {0.507020, 0.126679}, {1.000000, -0.000001, 0.000007}},
    {{14.500008, 24.000002, -0.500000}, {0.008316, 0.190115}, {1.000000, -0.000001, 0.000007}},
    {{14.499969, -24.000021, 0.500001}, {0.507020, 0.126679}, {1.000000, -0.000001, 0.000007}},
    {{14.499976, -24.000021, -0.499999}, {0.500060, 0.190115}, {1.000000, -0.000001, 0.000007}},
    {{-13.500013, -24.000002, -0.499999}, {0.522292, 0.319105}, {0.000000, -1.000000, 0.000000}},
    {{-13.500024, -24.000002, 0.500001}, {1.000000, 0.410954}, {0.000000, -1.000000, 0.000000}},
    {{-14.500017, -24.000002, 0.500001}, {0.991809, 0.474076}, {0.000000, -1.000000, 0.000000}},
    {{-13.500013, -24.000002, -0.499999}, {0.522292, 0.319105}, {0.000000, -1.000000, 0.000000}},
    {{-14.500017, -24.000002, 0.500001}, {0.991809, 0.474076}, {0.000000, -1.000000, 0.000000}},
    {{-14.500009, -24.000002, -0.499999}, {0.514102, 0.382227}, {0.000000, -1.000000, 0.000000}},
    {{14.499976, -24.000021, -0.499999}, {0.500060, 0.190115}, {0.000000, -1.000000, 0.000000}},
    {{14.499969, -24.000021, 0.500001}, {0.977774, 0.281964}, {0.000000, -1.000000, 0.000000}},
    {{13.499976, -24.000021, 0.500001}, {0.969583, 0.345087}, {0.000000, -1.000000, 0.000000}},
    {{14.499976, -24.000021, -0.499999}, {0.500060, 0.190115}, {0.000000, -1.000000, 0.000000}},
    {{13.499976, -24.000021, 0.500001}, {0.969583, 0.345087}, {0.000000, -1.000000, 0.000000}},
    {{13.499983, -24.000021, -0.499999}, {0.491869, 0.253238}, {0.000000, -1.000000, 0.000000}},
    {{-13.499992, 24.000021, 0.500000}, {0.007204, 0.508785}, {-0.000000, 0.000000, 1.000000}},
    {{-14.499987, 24.000021, 0.500000}, {0.015398, 0.445662}, {-0.000000, 0.000000, 1.000000}},
    {{-14.500017, -24.000002, 0.500001}, {0.507142, 0.445662}, {-0.000000, 0.000000, 1.000000}},
    {{-13.499992, 24.000021, 0.500000}, {0.007204, 0.508785}, {-0.000000, 0.000000, 1.000000}},
    {{-14.500017, -24.000002, 0.500001}, {0.507142, 0.445662}, {-0.000000, 0.000000, 1.000000}},
    {{-13.500024, -24.000002, 0.500001}, {0.498952, 0.508785}, {-0.000000, 0.000000, 1.000000}},
    {{-13.499982, 24.000021, -0.500000}, {0.000244, 0.572221}, {1.000000, -0.000001, 0.000010}},
    {{-13.499992, 24.000021, 0.500000}, {0.007204, 0.508785}, {1.000000, -0.000001, 0.000010}},
    {{-13.500024, -24.000002, 0.500001}, {0.498952, 0.508785}, {1.000000, -0.000001, 0.000010}},
    {{-13.499982, 24.000021, -0.500000}, {0.000244, 0.572221}, {1.000000, -0.000001, 0.000010}},
    {{-13.500024, -24.000002, 0.500001}, {0.498952, 0.508785}, {1.000000, -0.000001, 0.000010}},
    {{-13.500013, -24.000002, -0.499999}, {0.491992, 0.572221}, {1.000000, -0.000001, 0.000010}},
    {{-14.499987, 24.000021, 0.500000}, {0.015398, 0.445662}, {-1.000000, 0.000001, -0.000009}},
    {{-14.499978, 24.000021, -0.500000}, {0.022358, 0.382227}, {-1.000000, 0.000001, -0.000009}},
    {{-14.500009, -24.000002, -0.499999}, {0.514102, 0.382227}, {-1.000000, 0.000001, -0.000009}},
    {{-14.499987, 24.000021, 0.500000}, {0.015398, 0.445662}, {-1.000000, 0.000001, -0.000009}},
    {{-14.500009, -24.000002, -0.499999}, {0.514102, 0.382227}, {-1.000000, 0.000001, -0.000009}},
    {{-14.500017, -24.000002, 0.500001}, {0.507142, 0.445662}, {-1.000000, 0.000001, -0.000009}},
    {{14.500001, 24.000002, 0.500000}, {0.015276, 0.126679}, {-0.000000, 0.000000, 1.000000}},
    {{13.500008, 24.000002, 0.500000}, {0.023470, 0.063557}, {-0.000000, 0.000000, 1.000000}},
    {{13.499976, -24.000021, 0.500001}, {0.515210, 0.063557}, {-0.000000, 0.000000, 1.000000}},
    {{14.500001, 24.000002, 0.500000}, {0.015276, 0.126679}, {-0.000000, 0.000000, 1.000000}},
    {{13.499976, -24.000021, 0.500001}, {0.515210, 0.063557}, {-0.000000, 0.000000, 1.000000}},
    {{14.499969, -24.000021, 0.500001}, {0.507020, 0.126679}, {-0.000000, 0.000000, 1.000000}},
    {{-14.499978, 24.000021, -0.500000}, {0.022358, 0.382227}, {0.000000, -0.000000, -1.000000}},
    {{-13.499982, 24.000021, -0.500000}, {0.030552, 0.319105}, {0.000000, -0.000000, -1.000000}},
    {{-13.500013, -24.000002, -0.499999}, {0.522292, 0.319105}, {0.000000, -0.000000, -1.000000}},
    {{-14.499978, 24.000021, -0.500000}, {0.022358, 0.382227}, {0.000000, -0.000000, -1.000000}},
    {{-13.500013, -24.000002, -0.499999}, {0.522292, 0.319105}, {0.000000, -0.000000, -1.000000}},
    {{-14.500009, -24.000002, -0.499999}, {0.514102, 0.382227}, {0.000000, -0.000000, -1.000000}},
    {{13.500008, 24.000002, 0.500000}, {0.023470, 0.063557}, {-1.000000, 0.000001, -0.000007}},
    {{13.500014, 24.000002, -0.500000}, {0.030430, 0.000122}, {-1.000000, 0.000001, -0.000007}},
    {{13.499983, -24.000021, -0.499999}, {0.522170, 0.000122}, {-1.000000, 0.000001, -0.000007}},
    {{13.500008, 24.000002, 0.500000}, {0.023470, 0.063557}, {-1.000000, 0.000001, -0.000007}},
    {{13.499983, -24.000021, -0.499999}, {0.522170, 0.000122}, {-1.000000, 0.000001, -0.000007}},
    {{13.499976, -24.000021, 0.500001}, {0.515210, 0.063557}, {-1.000000, 0.000001, -0.000007}},
};

