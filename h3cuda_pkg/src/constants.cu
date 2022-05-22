#ifndef CONSTANTS
#define CONSTANTS

#include <math.h>
#include <stdio.h>

// Code modified from https://github.com/uber/h3/tree/e0aae450ffa7a63a3b7982573c88325b42231332
// with license https://github.com/uber/h3/blob/master/LICENSE Apache 2.0

// Apache License
// Version 2.0, January 2004
// http://www.apache.org/licenses/

// TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

// 1. Definitions.

// "License" shall mean the terms and conditions for use, reproduction,
// and distribution as defined by Sections 1 through 9 of this document.

// "Licensor" shall mean the copyright owner or entity authorized by
// the copyright owner that is granting the License.

// "Legal Entity" shall mean the union of the acting entity and all
// other entities that control, are controlled by, or are under common
// control with that entity. For the purposes of this definition,
// "control" means (i) the power, direct or indirect, to cause the
// direction or management of such entity, whether by contract or
// otherwise, or (ii) ownership of fifty percent (50%) or more of the
// outstanding shares, or (iii) beneficial ownership of such entity.

// "You" (or "Your") shall mean an individual or Legal Entity
// exercising permissions granted by this License.

// "Source" form shall mean the preferred form for making modifications,
// including but not limited to software source code, documentation
// source, and configuration files.

// "Object" form shall mean any form resulting from mechanical
// transformation or translation of a Source form, including but
// not limited to compiled object code, generated documentation,
// and conversions to other media types.

// "Work" shall mean the work of authorship, whether in Source or
// Object form, made available under the License, as indicated by a
// copyright notice that is included in or attached to the work
// (an example is provided in the Appendix below).

// "Derivative Works" shall mean any work, whether in Source or Object
// form, that is based on (or derived from) the Work and for which the
// editorial revisions, annotations, elaborations, or other modifications
// represent, as a whole, an original work of authorship. For the purposes
// of this License, Derivative Works shall not include works that remain
// separable from, or merely link (or bind by name) to the interfaces of,
// the Work and Derivative Works thereof.

// "Contribution" shall mean any work of authorship, including
// the original version of the Work and any modifications or additions
// to that Work or Derivative Works thereof, that is intentionally
// submitted to Licensor for inclusion in the Work by the copyright owner
// or by an individual or Legal Entity authorized to submit on behalf of
// the copyright owner. For the purposes of this definition, "submitted"
// means any form of electronic, verbal, or written communication sent
// to the Licensor or its representatives, including but not limited to
// communication on electronic mailing lists, source code control systems,
// and issue tracking systems that are managed by, or on behalf of, the
// Licensor for the purpose of discussing and improving the Work, but
// excluding communication that is conspicuously marked or otherwise
// designated in writing by the copyright owner as "Not a Contribution."

// "Contributor" shall mean Licensor and any individual or Legal Entity
// on behalf of whom a Contribution has been received by Licensor and
// subsequently incorporated within the Work.

// 2. Grant of Copyright License. Subject to the terms and conditions of
// this License, each Contributor hereby grants to You a perpetual,
// worldwide, non-exclusive, no-charge, royalty-free, irrevocable
// copyright license to reproduce, prepare Derivative Works of,
// publicly display, publicly perform, sublicense, and distribute the
// Work and such Derivative Works in Source or Object form.

// 3. Grant of Patent License. Subject to the terms and conditions of
// this License, each Contributor hereby grants to You a perpetual,
// worldwide, non-exclusive, no-charge, royalty-free, irrevocable
// (except as stated in this section) patent license to make, have made,
// use, offer to sell, sell, import, and otherwise transfer the Work,
// where such license applies only to those patent claims licensable
// by such Contributor that are necessarily infringed by their
// Contribution(s) alone or by combination of their Contribution(s)
// with the Work to which such Contribution(s) was submitted. If You
// institute patent litigation against any entity (including a
// cross-claim or counterclaim in a lawsuit) alleging that the Work
// or a Contribution incorporated within the Work constitutes direct
// or contributory patent infringement, then any patent licenses
// granted to You under this License for that Work shall terminate
// as of the date such litigation is filed.

// 4. Redistribution. You may reproduce and distribute copies of the
// Work or Derivative Works thereof in any medium, with or without
// modifications, and in Source or Object form, provided that You
// meet the following conditions:

// (a) You must give any other recipients of the Work or
// Derivative Works a copy of this License; and

// (b) You must cause any modified files to carry prominent notices
// stating that You changed the files; and

// (c) You must retain, in the Source form of any Derivative Works
// that You distribute, all copyright, patent, trademark, and
// attribution notices from the Source form of the Work,
// excluding those notices that do not pertain to any part of
// the Derivative Works; and

// (d) If the Work includes a "NOTICE" text file as part of its
// distribution, then any Derivative Works that You distribute must
// include a readable copy of the attribution notices contained
// within such NOTICE file, excluding those notices that do not
// pertain to any part of the Derivative Works, in at least one
// of the following places: within a NOTICE text file distributed
// as part of the Derivative Works; within the Source form or
// documentation, if provided along with the Derivative Works; or,
// within a display generated by the Derivative Works, if and
// wherever such third-party notices normally appear. The contents
// of the NOTICE file are for informational purposes only and
// do not modify the License. You may add Your own attribution
// notices within Derivative Works that You distribute, alongside
// or as an addendum to the NOTICE text from the Work, provided
// that such additional attribution notices cannot be construed
// as modifying the License.

// You may add Your own copyright statement to Your modifications and
// may provide additional or different license terms and conditions
// for use, reproduction, or distribution of Your modifications, or
// for any such Derivative Works as a whole, provided Your use,
// reproduction, and distribution of the Work otherwise complies with
// the conditions stated in this License.

// 5. Submission of Contributions. Unless You explicitly state otherwise,
// any Contribution intentionally submitted for inclusion in the Work
// by You to the Licensor shall be under the terms and conditions of
// this License, without any additional terms or conditions.
// Notwithstanding the above, nothing herein shall supersede or modify
// the terms of any separate license agreement you may have executed
// with Licensor regarding such Contributions.

// 6. Trademarks. This License does not grant permission to use the trade
// names, trademarks, service marks, or product names of the Licensor,
// except as required for reasonable and customary use in describing the
// origin of the Work and reproducing the content of the NOTICE file.

// 7. Disclaimer of Warranty. Unless required by applicable law or
// agreed to in writing, Licensor provides the Work (and each
// Contributor provides its Contributions) on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
// implied, including, without limitation, any warranties or conditions
// of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A
// PARTICULAR PURPOSE. You are solely responsible for determining the
// appropriateness of using or redistributing the Work and assume any
// risks associated with Your exercise of permissions under this License.

// 8. Limitation of Liability. In no event and under no legal theory,
// whether in tort (including negligence), contract, or otherwise,
// unless required by applicable law (such as deliberate and grossly
// negligent acts) or agreed to in writing, shall any Contributor be
// liable to You for damages, including any direct, indirect, special,
// incidental, or consequential damages of any character arising as a
// result of this License or out of the use or inability to use the
// Work (including but not limited to damages for loss of goodwill,
// work stoppage, computer failure or malfunction, or any and all
// other commercial damages or losses), even if such Contributor
// has been advised of the possibility of such damages.

// 9. Accepting Warranty or Additional Liability. While redistributing
// the Work or Derivative Works thereof, You may choose to offer,
// and charge a fee for, acceptance of support, warranty, indemnity,
// or other liability obligations and/or rights consistent with this
// License. However, in accepting such obligations, You may act only
// on Your own behalf and on Your sole responsibility, not on behalf
// of any other Contributor, and only if You agree to indemnify,
// defend, and hold each Contributor harmless for any liability
// incurred by, or claims asserted against, such Contributor by reason
// of your accepting any such warranty or additional liability.

// END OF TERMS AND CONDITIONS

// APPENDIX: How to apply the Apache License to your work.

// To apply the Apache License to your work, attach the following
// boilerplate notice, with the fields enclosed by brackets "[]"
// replaced with your own identifying information. (Don't include
// the brackets!)  The text should be enclosed in the appropriate
// comment syntax for the file format. We also recommend that a
// file or class name and description of purpose be included on the
// same "printed page" as the copyright notice for easier
// identification within third-party archives.

// Copyright [yyyy] [name of copyright owner]

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.



/** pi / 180 */
#define M_PI_180 0.0174532925199432957692369076848861271111
/** max H3 resolution; H3 version 1 has 16 resolutions, numbered 0 through 15 */
#define MAX_H3_RES 15
/** The number of faces on an icosahedron */
#define NUM_ICOSA_FACES 20
/** threshold epsilon */
#define EPSILON 0.0000000000000001
/** scaling factor from hex2d resolution 0 unit length
 * (or distance between adjacent cell center points
 * on the plane) to gnomonic unit length. */
#define RES0_U_GNOMONIC 0.38196601125010500003
/** 2.0 * PI */
#define M_2PI 6.28318530717958647692528676655900576839433
/** rotation angle between Class II and Class III resolution axes
 * (asin(sqrt(3.0 / 28.0))) */
#define M_AP7_ROT_RADS 0.333473172251832115336090755351601070065900389
/** square root of 7 */
#define M_SQRT7 2.6457513110645905905016157536392604257102
/** sqrt(3) / 2.0 */
#define M_SQRT3_2 0.8660254037844386467637231707529361834714
/** sin(60') */
#define M_SIN60 M_SQRT3_2
/** The bit offset of the mode in an H3 index. */
#define H3_MODE_OFFSET 59
/** 1's in the 4 mode bits, 0's everywhere else. */
#define H3_MODE_MASK ((uint64_t)(15) << H3_MODE_OFFSET)
/** 0's in the 4 mode bits, 1's everywhere else. */
#define H3_MODE_MASK_NEGATIVE (~H3_MODE_MASK)

/** The bit offset of the resolution in an H3 index. */
#define H3_RES_OFFSET 52
/** 1's in the 4 resolution bits, 0's everywhere else. */
#define H3_RES_MASK (UINT64_C(15) << H3_RES_OFFSET)
/** 0's in the 4 resolution bits, 1's everywhere else. */
#define H3_RES_MASK_NEGATIVE (~H3_RES_MASK)

/** The bit offset of the base cell in an H3 index. */
#define H3_BC_OFFSET 45
/** 1's in the 7 base cell bits, 0's everywhere else. */
#define H3_BC_MASK ((uint64_t)(127) << H3_BC_OFFSET)
/** 0's in the 7 base cell bits, 1's everywhere else. */
#define H3_BC_MASK_NEGATIVE (~H3_BC_MASK)

#define H3_CELL_MODE 1
/** Maximum input for any component to face-to-base-cell lookup functions */
#define MAX_FACE_COORD 2
/**
 * Invalid index used to indicate an error from latLngToCell and related
 * functions or missing data in arrays of H3 indices. Analogous to NaN in
 * floating point.
 */
#define H3_NULL 0
/** The number of H3 base cells */
#define NUM_BASE_CELLS 122

/**
 * Gets the integer resolution of h3.
 */
#define H3_GET_RESOLUTION(h3) ((int)((((h3)&H3_RES_MASK) >> H3_RES_OFFSET)))

/**
 * Sets the integer mode of h3 to v.
 */
#define H3_SET_MODE(h3, v)                                                     \
  (h3) = (((h3)&H3_MODE_MASK_NEGATIVE) | (((uint64_t)(v)) << H3_MODE_OFFSET))

/**
 * Sets the integer resolution of h3.
 */
#define H3_SET_RESOLUTION(h3, res)                                             \
  (h3) = (((h3)&H3_RES_MASK_NEGATIVE) | (((uint64_t)(res)) << H3_RES_OFFSET))

/**
 * Sets the integer base cell of h3 to bc.
 */
#define H3_SET_BASE_CELL(h3, bc)                                               \
  (h3) = (((h3)&H3_BC_MASK_NEGATIVE) | (((uint64_t)(bc)) << H3_BC_OFFSET))

/**
 * H3 index with mode 0, res 0, base cell 0, and 7 for all index digits.
 * Typically used to initialize the creation of an H3 cell index, which
 * expects all direction digits to be 7 beyond the cell's resolution.
 */
#define H3_INIT (UINT64_C(35184372088831))
/** The number of bits in a single H3 resolution digit. */
#define H3_PER_DIGIT_OFFSET 3

/** 1's in the 3 bits of res 15 digit bits, 0's everywhere else. */
#define H3_DIGIT_MASK ((uint64_t)(7))
/**
 * Sets the resolution res digit of h3 to the integer digit (0-7)
 */
#define H3_SET_INDEX_DIGIT(h3, res, digit)                                     \
  (h3) =                                                                       \
      (((h3) &                                                                 \
        ~((H3_DIGIT_MASK << ((MAX_H3_RES - (res)) * H3_PER_DIGIT_OFFSET)))) |  \
       (((uint64_t)(digit)) << ((MAX_H3_RES - (res)) * H3_PER_DIGIT_OFFSET)))

/** @brief H3 digit representing ijk+ axes direction.
 * Values will be within the lowest 3 bits of an integer.
 */
typedef enum {
  /** H3 digit in center */
  CENTER_DIGIT = 0,
  /** H3 digit in k-axes direction */
  K_AXES_DIGIT = 1,
  /** H3 digit in j-axes direction */
  J_AXES_DIGIT = 2,
  /** H3 digit in j == k direction */
  JK_AXES_DIGIT = J_AXES_DIGIT | K_AXES_DIGIT, /* 3 */
  /** H3 digit in i-axes direction */
  I_AXES_DIGIT = 4,
  /** H3 digit in i == k direction */
  IK_AXES_DIGIT = I_AXES_DIGIT | K_AXES_DIGIT, /* 5 */
  /** H3 digit in i == j direction */
  IJ_AXES_DIGIT = I_AXES_DIGIT | J_AXES_DIGIT, /* 6 */
  /** H3 digit in the invalid direction */
  INVALID_DIGIT = 7,
  /** Valid digits will be less than this value. Same value as INVALID_DIGIT.
   */
  NUM_DIGITS = INVALID_DIGIT,
  /** Child digit which is skipped for pentagons */
  PENTAGON_SKIPPED_DIGIT = K_AXES_DIGIT /* 1 */
} Direction;

/** @struct LatLng
    @brief latitude/longitude in radians
*/
typedef struct {
  double lat; ///< latitude in radians
  double lng; ///< longitude in radians
} LatLng;

/** @brief Result code (success or specific error) from an H3 operation */
typedef uint32_t H3Error;
/** @brief Identifier for an object (cell, edge, etc) in the H3 system.
 *
 * The H3Index fits within a 64-bit unsigned integer.
 */
typedef uint64_t H3Index;

typedef enum {
  E_SUCCESS = 0, // Success (no error)
  E_FAILED =
      1, // The operation failed but a more specific error is not available
  E_DOMAIN = 2, // Argument was outside of acceptable range (when a more
                // specific error code is not available)
  E_LATLNG_DOMAIN =
      3, // Latitude or longitude arguments were outside of acceptable range
  E_RES_DOMAIN = 4,       // Resolution argument was outside of acceptable range
  E_CELL_INVALID = 5,     // `H3Index` cell argument was not valid
  E_DIR_EDGE_INVALID = 6, // `H3Index` directed edge argument was not valid
  E_UNDIR_EDGE_INVALID = 7, // `H3Index` undirected edge argument was not valid
  E_VERTEX_INVALID = 8,     // `H3Index` vertex argument was not valid
  E_PENTAGON = 9, // Pentagon distortion was encountered which the algorithm
                  // could not handle it
  E_DUPLICATE_INPUT = 10, // Duplicate input was encountered in the arguments
                          // and the algorithm could not handle it
  E_NOT_NEIGHBORS = 11,   // `H3Index` cell arguments were not neighbors
  E_RES_MISMATCH = 12,  // `H3Index` cell arguments had incompatible resolutions
  E_MEMORY = 13,        // Necessary memory allocation failed
  E_MEMORY_BOUNDS = 14, // Bounds of provided memory were not large enough
  E_OPTION_INVALID = 15 // Mode or flags argument was not valid.
} H3ErrorCodes;

/** @struct CoordIJK
 * @brief IJK hexagon coordinates
 *
 * Each axis is spaced 120 degrees apart.
 */
typedef struct {
  int i; ///< i component
  int j; ///< j component
  int k; ///< k component
} CoordIJK;

/** @struct FaceIJK
 * @brief Face number and ijk coordinates on that face-centered coordinate
 * system
 */
typedef struct {
  int face;       ///< face number
  CoordIJK coord; ///< ijk coordinates on that face
} FaceIJK;

/** @struct Vec2d
 *  @brief 2D floating-point vector
 */
typedef struct {
  double x; ///< x component
  double y; ///< y component
} Vec2d;
/** @struct Vec3D
 *  @brief 3D floating point structure
 */
typedef struct {
  double x; ///< x component
  double y; ///< y component
  double z; ///< z component
} Vec3d;
/** @struct BaseCellRotation
 *  @brief base cell at a given ijk and required rotations into its system
 */
typedef struct {
  int baseCell; ///< base cell number
  int ccwRot60; ///< number of ccw 60 degree rotations relative to current
                /// face
} BaseCellRotation;

/** @struct BaseCellData
 * @brief information on a single base cell
 */
typedef struct {
  FaceIJK homeFijk; ///< "home" face and normalized ijk coordinates on that face
  int isPentagon;   ///< is this base cell a pentagon?
  int cwOffsetPent[2]; ///< if a pentagon, what are its two clockwise offset
                       /// faces?
} BaseCellData;

/**
 * Gets the resolution res integer digit (0-7) of h3.
 */
#define H3_GET_INDEX_DIGIT(h3, res)                                            \
  ((Direction)((((h3) >> ((MAX_H3_RES - (res)) * H3_PER_DIGIT_OFFSET)) &       \
                H3_DIGIT_MASK)))

/** @brief CoordIJK unit vectors corresponding to the 7 H3 digits.
 */
__device__ static const CoordIJK UNIT_VECS[] = {
    {0, 0, 0}, // direction 0
    {0, 0, 1}, // direction 1
    {0, 1, 0}, // direction 2
    {0, 1, 1}, // direction 3
    {1, 0, 0}, // direction 4
    {1, 0, 1}, // direction 5
    {1, 1, 0}  // direction 6
};

/** @brief Resolution 0 base cell data table.
 *
 * For each base cell, gives the "home" face and ijk+ coordinates on that face,
 * whether or not the base cell is a pentagon. Additionally, if the base cell
 * is a pentagon, the two cw offset rotation adjacent faces are given (-1
 * indicates that no cw offset rotation faces exist for this base cell).
 */
__device__ const BaseCellData baseCellData[NUM_BASE_CELLS] = {

    {{1, {1, 0, 0}}, 0, {0, 0}},    // base cell 0
    {{2, {1, 1, 0}}, 0, {0, 0}},    // base cell 1
    {{1, {0, 0, 0}}, 0, {0, 0}},    // base cell 2
    {{2, {1, 0, 0}}, 0, {0, 0}},    // base cell 3
    {{0, {2, 0, 0}}, 1, {-1, -1}},  // base cell 4
    {{1, {1, 1, 0}}, 0, {0, 0}},    // base cell 5
    {{1, {0, 0, 1}}, 0, {0, 0}},    // base cell 6
    {{2, {0, 0, 0}}, 0, {0, 0}},    // base cell 7
    {{0, {1, 0, 0}}, 0, {0, 0}},    // base cell 8
    {{2, {0, 1, 0}}, 0, {0, 0}},    // base cell 9
    {{1, {0, 1, 0}}, 0, {0, 0}},    // base cell 10
    {{1, {0, 1, 1}}, 0, {0, 0}},    // base cell 11
    {{3, {1, 0, 0}}, 0, {0, 0}},    // base cell 12
    {{3, {1, 1, 0}}, 0, {0, 0}},    // base cell 13
    {{11, {2, 0, 0}}, 1, {2, 6}},   // base cell 14
    {{4, {1, 0, 0}}, 0, {0, 0}},    // base cell 15
    {{0, {0, 0, 0}}, 0, {0, 0}},    // base cell 16
    {{6, {0, 1, 0}}, 0, {0, 0}},    // base cell 17
    {{0, {0, 0, 1}}, 0, {0, 0}},    // base cell 18
    {{2, {0, 1, 1}}, 0, {0, 0}},    // base cell 19
    {{7, {0, 0, 1}}, 0, {0, 0}},    // base cell 20
    {{2, {0, 0, 1}}, 0, {0, 0}},    // base cell 21
    {{0, {1, 1, 0}}, 0, {0, 0}},    // base cell 22
    {{6, {0, 0, 1}}, 0, {0, 0}},    // base cell 23
    {{10, {2, 0, 0}}, 1, {1, 5}},   // base cell 24
    {{6, {0, 0, 0}}, 0, {0, 0}},    // base cell 25
    {{3, {0, 0, 0}}, 0, {0, 0}},    // base cell 26
    {{11, {1, 0, 0}}, 0, {0, 0}},   // base cell 27
    {{4, {1, 1, 0}}, 0, {0, 0}},    // base cell 28
    {{3, {0, 1, 0}}, 0, {0, 0}},    // base cell 29
    {{0, {0, 1, 1}}, 0, {0, 0}},    // base cell 30
    {{4, {0, 0, 0}}, 0, {0, 0}},    // base cell 31
    {{5, {0, 1, 0}}, 0, {0, 0}},    // base cell 32
    {{0, {0, 1, 0}}, 0, {0, 0}},    // base cell 33
    {{7, {0, 1, 0}}, 0, {0, 0}},    // base cell 34
    {{11, {1, 1, 0}}, 0, {0, 0}},   // base cell 35
    {{7, {0, 0, 0}}, 0, {0, 0}},    // base cell 36
    {{10, {1, 0, 0}}, 0, {0, 0}},   // base cell 37
    {{12, {2, 0, 0}}, 1, {3, 7}},   // base cell 38
    {{6, {1, 0, 1}}, 0, {0, 0}},    // base cell 39
    {{7, {1, 0, 1}}, 0, {0, 0}},    // base cell 40
    {{4, {0, 0, 1}}, 0, {0, 0}},    // base cell 41
    {{3, {0, 0, 1}}, 0, {0, 0}},    // base cell 42
    {{3, {0, 1, 1}}, 0, {0, 0}},    // base cell 43
    {{4, {0, 1, 0}}, 0, {0, 0}},    // base cell 44
    {{6, {1, 0, 0}}, 0, {0, 0}},    // base cell 45
    {{11, {0, 0, 0}}, 0, {0, 0}},   // base cell 46
    {{8, {0, 0, 1}}, 0, {0, 0}},    // base cell 47
    {{5, {0, 0, 1}}, 0, {0, 0}},    // base cell 48
    {{14, {2, 0, 0}}, 1, {0, 9}},   // base cell 49
    {{5, {0, 0, 0}}, 0, {0, 0}},    // base cell 50
    {{12, {1, 0, 0}}, 0, {0, 0}},   // base cell 51
    {{10, {1, 1, 0}}, 0, {0, 0}},   // base cell 52
    {{4, {0, 1, 1}}, 0, {0, 0}},    // base cell 53
    {{12, {1, 1, 0}}, 0, {0, 0}},   // base cell 54
    {{7, {1, 0, 0}}, 0, {0, 0}},    // base cell 55
    {{11, {0, 1, 0}}, 0, {0, 0}},   // base cell 56
    {{10, {0, 0, 0}}, 0, {0, 0}},   // base cell 57
    {{13, {2, 0, 0}}, 1, {4, 8}},   // base cell 58
    {{10, {0, 0, 1}}, 0, {0, 0}},   // base cell 59
    {{11, {0, 0, 1}}, 0, {0, 0}},   // base cell 60
    {{9, {0, 1, 0}}, 0, {0, 0}},    // base cell 61
    {{8, {0, 1, 0}}, 0, {0, 0}},    // base cell 62
    {{6, {2, 0, 0}}, 1, {11, 15}},  // base cell 63
    {{8, {0, 0, 0}}, 0, {0, 0}},    // base cell 64
    {{9, {0, 0, 1}}, 0, {0, 0}},    // base cell 65
    {{14, {1, 0, 0}}, 0, {0, 0}},   // base cell 66
    {{5, {1, 0, 1}}, 0, {0, 0}},    // base cell 67
    {{16, {0, 1, 1}}, 0, {0, 0}},   // base cell 68
    {{8, {1, 0, 1}}, 0, {0, 0}},    // base cell 69
    {{5, {1, 0, 0}}, 0, {0, 0}},    // base cell 70
    {{12, {0, 0, 0}}, 0, {0, 0}},   // base cell 71
    {{7, {2, 0, 0}}, 1, {12, 16}},  // base cell 72
    {{12, {0, 1, 0}}, 0, {0, 0}},   // base cell 73
    {{10, {0, 1, 0}}, 0, {0, 0}},   // base cell 74
    {{9, {0, 0, 0}}, 0, {0, 0}},    // base cell 75
    {{13, {1, 0, 0}}, 0, {0, 0}},   // base cell 76
    {{16, {0, 0, 1}}, 0, {0, 0}},   // base cell 77
    {{15, {0, 1, 1}}, 0, {0, 0}},   // base cell 78
    {{15, {0, 1, 0}}, 0, {0, 0}},   // base cell 79
    {{16, {0, 1, 0}}, 0, {0, 0}},   // base cell 80
    {{14, {1, 1, 0}}, 0, {0, 0}},   // base cell 81
    {{13, {1, 1, 0}}, 0, {0, 0}},   // base cell 82
    {{5, {2, 0, 0}}, 1, {10, 19}},  // base cell 83
    {{8, {1, 0, 0}}, 0, {0, 0}},    // base cell 84
    {{14, {0, 0, 0}}, 0, {0, 0}},   // base cell 85
    {{9, {1, 0, 1}}, 0, {0, 0}},    // base cell 86
    {{14, {0, 0, 1}}, 0, {0, 0}},   // base cell 87
    {{17, {0, 0, 1}}, 0, {0, 0}},   // base cell 88
    {{12, {0, 0, 1}}, 0, {0, 0}},   // base cell 89
    {{16, {0, 0, 0}}, 0, {0, 0}},   // base cell 90
    {{17, {0, 1, 1}}, 0, {0, 0}},   // base cell 91
    {{15, {0, 0, 1}}, 0, {0, 0}},   // base cell 92
    {{16, {1, 0, 1}}, 0, {0, 0}},   // base cell 93
    {{9, {1, 0, 0}}, 0, {0, 0}},    // base cell 94
    {{15, {0, 0, 0}}, 0, {0, 0}},   // base cell 95
    {{13, {0, 0, 0}}, 0, {0, 0}},   // base cell 96
    {{8, {2, 0, 0}}, 1, {13, 17}},  // base cell 97
    {{13, {0, 1, 0}}, 0, {0, 0}},   // base cell 98
    {{17, {1, 0, 1}}, 0, {0, 0}},   // base cell 99
    {{19, {0, 1, 0}}, 0, {0, 0}},   // base cell 100
    {{14, {0, 1, 0}}, 0, {0, 0}},   // base cell 101
    {{19, {0, 1, 1}}, 0, {0, 0}},   // base cell 102
    {{17, {0, 1, 0}}, 0, {0, 0}},   // base cell 103
    {{13, {0, 0, 1}}, 0, {0, 0}},   // base cell 104
    {{17, {0, 0, 0}}, 0, {0, 0}},   // base cell 105
    {{16, {1, 0, 0}}, 0, {0, 0}},   // base cell 106
    {{9, {2, 0, 0}}, 1, {14, 18}},  // base cell 107
    {{15, {1, 0, 1}}, 0, {0, 0}},   // base cell 108
    {{15, {1, 0, 0}}, 0, {0, 0}},   // base cell 109
    {{18, {0, 1, 1}}, 0, {0, 0}},   // base cell 110
    {{18, {0, 0, 1}}, 0, {0, 0}},   // base cell 111
    {{19, {0, 0, 1}}, 0, {0, 0}},   // base cell 112
    {{17, {1, 0, 0}}, 0, {0, 0}},   // base cell 113
    {{19, {0, 0, 0}}, 0, {0, 0}},   // base cell 114
    {{18, {0, 1, 0}}, 0, {0, 0}},   // base cell 115
    {{18, {1, 0, 1}}, 0, {0, 0}},   // base cell 116
    {{19, {2, 0, 0}}, 1, {-1, -1}}, // base cell 117
    {{19, {1, 0, 0}}, 0, {0, 0}},   // base cell 118
    {{18, {0, 0, 0}}, 0, {0, 0}},   // base cell 119
    {{19, {1, 0, 1}}, 0, {0, 0}},   // base cell 120
    {{18, {1, 0, 0}}, 0, {0, 0}}    // base cell 121
};

/** @brief icosahedron face centers in lat/lng radians */
__device__ const LatLng faceCenterGeo[NUM_ICOSA_FACES] = {
    {0.803582649718989942, 1.248397419617396099},   // face  0
    {1.307747883455638156, 2.536945009877921159},   // face  1
    {1.054751253523952054, -1.347517358900396623},  // face  2
    {0.600191595538186799, -0.450603909469755746},  // face  3
    {0.491715428198773866, 0.401988202911306943},   // face  4
    {0.172745327415618701, 1.678146885280433686},   // face  5
    {0.605929321571350690, 2.953923329812411617},   // face  6
    {0.427370518328979641, -1.888876200336285401},  // face  7
    {-0.079066118549212831, -0.733429513380867741}, // face  8
    {-0.230961644455383637, 0.506495587332349035},  // face  9
    {0.079066118549212831, 2.408163140208925497},   // face 10
    {0.230961644455383637, -2.635097066257444203},  // face 11
    {-0.172745327415618701, -1.463445768309359553}, // face 12
    {-0.605929321571350690, -0.187669323777381622}, // face 13
    {-0.427370518328979641, 1.252716453253507838},  // face 14
    {-0.600191595538186799, 2.690988744120037492},  // face 15
    {-0.491715428198773866, -2.739604450678486295}, // face 16
    {-0.803582649718989942, -1.893195233972397139}, // face 17
    {-1.307747883455638156, -0.604647643711872080}, // face 18
    {-1.054751253523952054, 1.794075294689396615},  // face 19
};

/** @brief icosahedron face centers in x/y/z on the unit sphere */
__device__ static const Vec3d faceCenterPoint[NUM_ICOSA_FACES] = {
    {0.2199307791404606, 0.6583691780274996, 0.7198475378926182},    // face  0
    {-0.2139234834501421, 0.1478171829550703, 0.9656017935214205},   // face  1
    {0.1092625278784797, -0.4811951572873210, 0.8697775121287253},   // face  2
    {0.7428567301586791, -0.3593941678278028, 0.5648005936517033},   // face  3
    {0.8112534709140969, 0.3448953237639384, 0.4721387736413930},    // face  4
    {-0.1055498149613921, 0.9794457296411413, 0.1718874610009365},   // face  5
    {-0.8075407579970092, 0.1533552485898818, 0.5695261994882688},   // face  6
    {-0.2846148069787907, -0.8644080972654206, 0.4144792552473539},  // face  7
    {0.7405621473854482, -0.6673299564565524, -0.0789837646326737},  // face  8
    {0.8512303986474293, 0.4722343788582681, -0.2289137388687808},   // face  9
    {-0.7405621473854481, 0.6673299564565524, 0.0789837646326737},   // face 10
    {-0.8512303986474292, -0.4722343788582682, 0.2289137388687808},  // face 11
    {0.1055498149613919, -0.9794457296411413, -0.1718874610009365},  // face 12
    {0.8075407579970092, -0.1533552485898819, -0.5695261994882688},  // face 13
    {0.2846148069787908, 0.8644080972654204, -0.4144792552473539},   // face 14
    {-0.7428567301586791, 0.3593941678278027, -0.5648005936517033},  // face 15
    {-0.8112534709140971, -0.3448953237639382, -0.4721387736413930}, // face 16
    {-0.2199307791404607, -0.6583691780274996, -0.7198475378926182}, // face 17
    {0.2139234834501420, -0.1478171829550704, -0.9656017935214205},  // face 18
    {-0.1092625278784796, 0.4811951572873210, -0.8697775121287253},  // face 19
};

/** @brief icosahedron face ijk axes as azimuth in radians from face center to
 * vertex 0/1/2 respectively
 */
__device__ static const double faceAxesAzRadsCII[NUM_ICOSA_FACES][3] = {
    {5.619958268523939882, 3.525563166130744542,
     1.431168063737548730}, // face  0
    {5.760339081714187279, 3.665943979320991689,
     1.571548876927796127}, // face  1
    {0.780213654393430055, 4.969003859179821079,
     2.874608756786625655}, // face  2
    {0.430469363979999913, 4.619259568766391033,
     2.524864466373195467}, // face  3
    {6.130269123335111400, 4.035874020941915804,
     1.941478918548720291}, // face  4
    {2.692877706530642877, 0.598482604137447119,
     4.787272808923838195}, // face  5
    {2.982963003477243874, 0.888567901084048369,
     5.077358105870439581}, // face  6
    {3.532912002790141181, 1.438516900396945656,
     5.627307105183336758}, // face  7
    {3.494305004259568154, 1.399909901866372864,
     5.588700106652763840}, // face  8
    {3.003214169499538391, 0.908819067106342928,
     5.097609271892733906}, // face  9
    {5.930472956509811562, 3.836077854116615875,
     1.741682751723420374}, // face 10
    {0.138378484090254847, 4.327168688876645809,
     2.232773586483450311}, // face 11
    {0.448714947059150361, 4.637505151845541521,
     2.543110049452346120}, // face 12
    {0.158629650112549365, 4.347419854898940135,
     2.253024752505744869}, // face 13
    {5.891865957979238535, 3.797470855586042958,
     1.703075753192847583}, // face 14
    {2.711123289609793325, 0.616728187216597771,
     4.805518392002988683}, // face 15
    {3.294508837434268316, 1.200113735041072948,
     5.388903939827463911}, // face 16
    {3.804819692245439833, 1.710424589852244509,
     5.899214794638635174}, // face 17
    {3.664438879055192436, 1.570043776661997111,
     5.758833981448388027}, // face 18
    {2.361378999196363184, 0.266983896803167583,
     4.455774101589558636}, // face 19
};

/** @brief Resolution 0 base cell lookup table for each face.
 *
 * Given the face number and a resolution 0 ijk+ coordinate in that face's
 * face-centered ijk coordinate system, gives the base cell located at that
 * coordinate and the number of 60 ccw rotations to rotate into that base
 * cell's orientation.
 *
 * Valid lookup coordinates are from (0, 0, 0) to (2, 2, 2).
 *
 * This table can be accessed using the functions `_faceIjkToBaseCell` and
 * `_faceIjkToBaseCellCCWrot60`
 */
__device__ static const BaseCellRotation
    faceIjkBaseCells[NUM_ICOSA_FACES][3][3][3] = {
        {// face 0
         {
             // i 0
             {{16, 0}, {18, 0}, {24, 0}}, // j 0
             {{33, 0}, {30, 0}, {32, 3}}, // j 1
             {{49, 1}, {48, 3}, {50, 3}}  // j 2
         },
         {
             // i 1
             {{8, 0}, {5, 5}, {10, 5}},   // j 0
             {{22, 0}, {16, 0}, {18, 0}}, // j 1
             {{41, 1}, {33, 0}, {30, 0}}  // j 2
         },
         {
             // i 2
             {{4, 0}, {0, 5}, {2, 5}},   // j 0
             {{15, 1}, {8, 0}, {5, 5}},  // j 1
             {{31, 1}, {22, 0}, {16, 0}} // j 2
         }},
        {// face 1
         {
             // i 0
             {{2, 0}, {6, 0}, {14, 0}},   // j 0
             {{10, 0}, {11, 0}, {17, 3}}, // j 1
             {{24, 1}, {23, 3}, {25, 3}}  // j 2
         },
         {
             // i 1
             {{0, 0}, {1, 5}, {9, 5}},   // j 0
             {{5, 0}, {2, 0}, {6, 0}},   // j 1
             {{18, 1}, {10, 0}, {11, 0}} // j 2
         },
         {
             // i 2
             {{4, 1}, {3, 5}, {7, 5}}, // j 0
             {{8, 1}, {0, 0}, {1, 5}}, // j 1
             {{16, 1}, {5, 0}, {2, 0}} // j 2
         }},
        {// face 2
         {
             // i 0
             {{7, 0}, {21, 0}, {38, 0}}, // j 0
             {{9, 0}, {19, 0}, {34, 3}}, // j 1
             {{14, 1}, {20, 3}, {36, 3}} // j 2
         },
         {
             // i 1
             {{3, 0}, {13, 5}, {29, 5}}, // j 0
             {{1, 0}, {7, 0}, {21, 0}},  // j 1
             {{6, 1}, {9, 0}, {19, 0}}   // j 2
         },
         {
             // i 2
             {{4, 2}, {12, 5}, {26, 5}}, // j 0
             {{0, 1}, {3, 0}, {13, 5}},  // j 1
             {{2, 1}, {1, 0}, {7, 0}}    // j 2
         }},
        {// face 3
         {
             // i 0
             {{26, 0}, {42, 0}, {58, 0}}, // j 0
             {{29, 0}, {43, 0}, {62, 3}}, // j 1
             {{38, 1}, {47, 3}, {64, 3}}  // j 2
         },
         {
             // i 1
             {{12, 0}, {28, 5}, {44, 5}}, // j 0
             {{13, 0}, {26, 0}, {42, 0}}, // j 1
             {{21, 1}, {29, 0}, {43, 0}}  // j 2
         },
         {
             // i 2
             {{4, 3}, {15, 5}, {31, 5}}, // j 0
             {{3, 1}, {12, 0}, {28, 5}}, // j 1
             {{7, 1}, {13, 0}, {26, 0}}  // j 2
         }},
        {// face 4
         {
             // i 0
             {{31, 0}, {41, 0}, {49, 0}}, // j 0
             {{44, 0}, {53, 0}, {61, 3}}, // j 1
             {{58, 1}, {65, 3}, {75, 3}}  // j 2
         },
         {
             // i 1
             {{15, 0}, {22, 5}, {33, 5}}, // j 0
             {{28, 0}, {31, 0}, {41, 0}}, // j 1
             {{42, 1}, {44, 0}, {53, 0}}  // j 2
         },
         {
             // i 2
             {{4, 4}, {8, 5}, {16, 5}},   // j 0
             {{12, 1}, {15, 0}, {22, 5}}, // j 1
             {{26, 1}, {28, 0}, {31, 0}}  // j 2
         }},
        {// face 5
         {
             // i 0
             {{50, 0}, {48, 0}, {49, 3}}, // j 0
             {{32, 0}, {30, 3}, {33, 3}}, // j 1
             {{24, 3}, {18, 3}, {16, 3}}  // j 2
         },
         {
             // i 1
             {{70, 0}, {67, 0}, {66, 3}}, // j 0
             {{52, 3}, {50, 0}, {48, 0}}, // j 1
             {{37, 3}, {32, 0}, {30, 3}}  // j 2
         },
         {
             // i 2
             {{83, 0}, {87, 3}, {85, 3}}, // j 0
             {{74, 3}, {70, 0}, {67, 0}}, // j 1
             {{57, 1}, {52, 3}, {50, 0}}  // j 2
         }},
        {// face 6
         {
             // i 0
             {{25, 0}, {23, 0}, {24, 3}}, // j 0
             {{17, 0}, {11, 3}, {10, 3}}, // j 1
             {{14, 3}, {6, 3}, {2, 3}}    // j 2
         },
         {
             // i 1
             {{45, 0}, {39, 0}, {37, 3}}, // j 0
             {{35, 3}, {25, 0}, {23, 0}}, // j 1
             {{27, 3}, {17, 0}, {11, 3}}  // j 2
         },
         {
             // i 2
             {{63, 0}, {59, 3}, {57, 3}}, // j 0
             {{56, 3}, {45, 0}, {39, 0}}, // j 1
             {{46, 3}, {35, 3}, {25, 0}}  // j 2
         }},
        {// face 7
         {
             // i 0
             {{36, 0}, {20, 0}, {14, 3}}, // j 0
             {{34, 0}, {19, 3}, {9, 3}},  // j 1
             {{38, 3}, {21, 3}, {7, 3}}   // j 2
         },
         {
             // i 1
             {{55, 0}, {40, 0}, {27, 3}}, // j 0
             {{54, 3}, {36, 0}, {20, 0}}, // j 1
             {{51, 3}, {34, 0}, {19, 3}}  // j 2
         },
         {
             // i 2
             {{72, 0}, {60, 3}, {46, 3}}, // j 0
             {{73, 3}, {55, 0}, {40, 0}}, // j 1
             {{71, 3}, {54, 3}, {36, 0}}  // j 2
         }},
        {// face 8
         {
             // i 0
             {{64, 0}, {47, 0}, {38, 3}}, // j 0
             {{62, 0}, {43, 3}, {29, 3}}, // j 1
             {{58, 3}, {42, 3}, {26, 3}}  // j 2
         },
         {
             // i 1
             {{84, 0}, {69, 0}, {51, 3}}, // j 0
             {{82, 3}, {64, 0}, {47, 0}}, // j 1
             {{76, 3}, {62, 0}, {43, 3}}  // j 2
         },
         {
             // i 2
             {{97, 0}, {89, 3}, {71, 3}}, // j 0
             {{98, 3}, {84, 0}, {69, 0}}, // j 1
             {{96, 3}, {82, 3}, {64, 0}}  // j 2
         }},
        {// face 9
         {
             // i 0
             {{75, 0}, {65, 0}, {58, 3}}, // j 0
             {{61, 0}, {53, 3}, {44, 3}}, // j 1
             {{49, 3}, {41, 3}, {31, 3}}  // j 2
         },
         {
             // i 1
             {{94, 0}, {86, 0}, {76, 3}}, // j 0
             {{81, 3}, {75, 0}, {65, 0}}, // j 1
             {{66, 3}, {61, 0}, {53, 3}}  // j 2
         },
         {
             // i 2
             {{107, 0}, {104, 3}, {96, 3}}, // j 0
             {{101, 3}, {94, 0}, {86, 0}},  // j 1
             {{85, 3}, {81, 3}, {75, 0}}    // j 2
         }},
        {// face 10
         {
             // i 0
             {{57, 0}, {59, 0}, {63, 3}}, // j 0
             {{74, 0}, {78, 3}, {79, 3}}, // j 1
             {{83, 3}, {92, 3}, {95, 3}}  // j 2
         },
         {
             // i 1
             {{37, 0}, {39, 3}, {45, 3}}, // j 0
             {{52, 0}, {57, 0}, {59, 0}}, // j 1
             {{70, 3}, {74, 0}, {78, 3}}  // j 2
         },
         {
             // i 2
             {{24, 0}, {23, 3}, {25, 3}}, // j 0
             {{32, 3}, {37, 0}, {39, 3}}, // j 1
             {{50, 3}, {52, 0}, {57, 0}}  // j 2
         }},
        {// face 11
         {
             // i 0
             {{46, 0}, {60, 0}, {72, 3}}, // j 0
             {{56, 0}, {68, 3}, {80, 3}}, // j 1
             {{63, 3}, {77, 3}, {90, 3}}  // j 2
         },
         {
             // i 1
             {{27, 0}, {40, 3}, {55, 3}}, // j 0
             {{35, 0}, {46, 0}, {60, 0}}, // j 1
             {{45, 3}, {56, 0}, {68, 3}}  // j 2
         },
         {
             // i 2
             {{14, 0}, {20, 3}, {36, 3}}, // j 0
             {{17, 3}, {27, 0}, {40, 3}}, // j 1
             {{25, 3}, {35, 0}, {46, 0}}  // j 2
         }},
        {// face 12
         {
             // i 0
             {{71, 0}, {89, 0}, {97, 3}},  // j 0
             {{73, 0}, {91, 3}, {103, 3}}, // j 1
             {{72, 3}, {88, 3}, {105, 3}}  // j 2
         },
         {
             // i 1
             {{51, 0}, {69, 3}, {84, 3}}, // j 0
             {{54, 0}, {71, 0}, {89, 0}}, // j 1
             {{55, 3}, {73, 0}, {91, 3}}  // j 2
         },
         {
             // i 2
             {{38, 0}, {47, 3}, {64, 3}}, // j 0
             {{34, 3}, {51, 0}, {69, 3}}, // j 1
             {{36, 3}, {54, 0}, {71, 0}}  // j 2
         }},
        {// face 13
         {
             // i 0
             {{96, 0}, {104, 0}, {107, 3}}, // j 0
             {{98, 0}, {110, 3}, {115, 3}}, // j 1
             {{97, 3}, {111, 3}, {119, 3}}  // j 2
         },
         {
             // i 1
             {{76, 0}, {86, 3}, {94, 3}},  // j 0
             {{82, 0}, {96, 0}, {104, 0}}, // j 1
             {{84, 3}, {98, 0}, {110, 3}}  // j 2
         },
         {
             // i 2
             {{58, 0}, {65, 3}, {75, 3}}, // j 0
             {{62, 3}, {76, 0}, {86, 3}}, // j 1
             {{64, 3}, {82, 0}, {96, 0}}  // j 2
         }},
        {// face 14
         {
             // i 0
             {{85, 0}, {87, 0}, {83, 3}},    // j 0
             {{101, 0}, {102, 3}, {100, 3}}, // j 1
             {{107, 3}, {112, 3}, {114, 3}}  // j 2
         },
         {
             // i 1
             {{66, 0}, {67, 3}, {70, 3}},  // j 0
             {{81, 0}, {85, 0}, {87, 0}},  // j 1
             {{94, 3}, {101, 0}, {102, 3}} // j 2
         },
         {
             // i 2
             {{49, 0}, {48, 3}, {50, 3}}, // j 0
             {{61, 3}, {66, 0}, {67, 3}}, // j 1
             {{75, 3}, {81, 0}, {85, 0}}  // j 2
         }},
        {// face 15
         {
             // i 0
             {{95, 0}, {92, 0}, {83, 0}}, // j 0
             {{79, 0}, {78, 0}, {74, 3}}, // j 1
             {{63, 1}, {59, 3}, {57, 3}}  // j 2
         },
         {
             // i 1
             {{109, 0}, {108, 0}, {100, 5}}, // j 0
             {{93, 1}, {95, 0}, {92, 0}},    // j 1
             {{77, 1}, {79, 0}, {78, 0}}     // j 2
         },
         {
             // i 2
             {{117, 4}, {118, 5}, {114, 5}}, // j 0
             {{106, 1}, {109, 0}, {108, 0}}, // j 1
             {{90, 1}, {93, 1}, {95, 0}}     // j 2
         }},
        {// face 16
         {
             // i 0
             {{90, 0}, {77, 0}, {63, 0}}, // j 0
             {{80, 0}, {68, 0}, {56, 3}}, // j 1
             {{72, 1}, {60, 3}, {46, 3}}  // j 2
         },
         {
             // i 1
             {{106, 0}, {93, 0}, {79, 5}}, // j 0
             {{99, 1}, {90, 0}, {77, 0}},  // j 1
             {{88, 1}, {80, 0}, {68, 0}}   // j 2
         },
         {
             // i 2
             {{117, 3}, {109, 5}, {95, 5}}, // j 0
             {{113, 1}, {106, 0}, {93, 0}}, // j 1
             {{105, 1}, {99, 1}, {90, 0}}   // j 2
         }},
        {// face 17
         {
             // i 0
             {{105, 0}, {88, 0}, {72, 0}}, // j 0
             {{103, 0}, {91, 0}, {73, 3}}, // j 1
             {{97, 1}, {89, 3}, {71, 3}}   // j 2
         },
         {
             // i 1
             {{113, 0}, {99, 0}, {80, 5}},  // j 0
             {{116, 1}, {105, 0}, {88, 0}}, // j 1
             {{111, 1}, {103, 0}, {91, 0}}  // j 2
         },
         {
             // i 2
             {{117, 2}, {106, 5}, {90, 5}}, // j 0
             {{121, 1}, {113, 0}, {99, 0}}, // j 1
             {{119, 1}, {116, 1}, {105, 0}} // j 2
         }},
        {// face 18
         {
             // i 0
             {{119, 0}, {111, 0}, {97, 0}}, // j 0
             {{115, 0}, {110, 0}, {98, 3}}, // j 1
             {{107, 1}, {104, 3}, {96, 3}}  // j 2
         },
         {
             // i 1
             {{121, 0}, {116, 0}, {103, 5}}, // j 0
             {{120, 1}, {119, 0}, {111, 0}}, // j 1
             {{112, 1}, {115, 0}, {110, 0}}  // j 2
         },
         {
             // i 2
             {{117, 1}, {113, 5}, {105, 5}}, // j 0
             {{118, 1}, {121, 0}, {116, 0}}, // j 1
             {{114, 1}, {120, 1}, {119, 0}}  // j 2
         }},
        {// face 19
         {
             // i 0
             {{114, 0}, {112, 0}, {107, 0}}, // j 0
             {{100, 0}, {102, 0}, {101, 3}}, // j 1
             {{83, 1}, {87, 3}, {85, 3}}     // j 2
         },
         {
             // i 1
             {{118, 0}, {120, 0}, {115, 5}}, // j 0
             {{108, 1}, {114, 0}, {112, 0}}, // j 1
             {{92, 1}, {100, 0}, {102, 0}}   // j 2
         },
         {
             // i 2
             {{117, 0}, {121, 5}, {119, 5}}, // j 0
             {{109, 1}, {118, 0}, {120, 0}}, // j 1
             {{95, 1}, {108, 1}, {114, 0}}   // j 2
         }}};


#endif