#ifndef KERNEL
#define KERNEL

#include <constants.cu>
#include <math.h>
#include <stdio.h>

// Code modified from
// https://github.com/uber/h3/tree/e0aae450ffa7a63a3b7982573c88325b42231332 with
// license https://github.com/uber/h3/blob/master/LICENSE Apache 2.0

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

/**
 * Convert from decimal degrees to radians.
 *
 * @param degrees The decimal degrees.
 * @return The corresponding radians.
 */
__device__ double degsToRads(double degrees) { return degrees * M_PI_180; }

/**
 * Normalizes radians to a value between 0.0 and two PI.
 *
 * @param rads The input radians value.
 * @return The normalized radians value.
 */
__device__ double _posAngleRads(double rads) {
  double tmp = ((rads < 0.0) ? rads + M_2PI : rads);
  if (rads >= M_2PI)
    tmp -= M_2PI;
  return tmp;
}
/**
 * Determines the azimuth to p2 from p1 in radians.
 *
 * @param p1 The first spherical coordinates.
 * @param p2 The second spherical coordinates.
 * @return The azimuth in radians from p1 to p2.
 */
__device__ double _geoAzimuthRads(const LatLng *p1, const LatLng *p2) {
  return atan2(cos(p2->lat) * sin(p2->lng - p1->lng),
               cos(p1->lat) * sin(p2->lat) -
                   sin(p1->lat) * cos(p2->lat) * cos(p2->lng - p1->lng));
}

/**
 * Returns whether or not a resolution is a Class III grid. Note that odd
 * resolutions are Class III and even resolutions are Class II.
 * @param res The H3 resolution.
 * @return 1 if the resolution is a Class III grid, and 0 if the resolution is
 *         a Class II grid.
 */
__device__ int isResolutionClassIII(int res) { return res % 2; }

/**
 * Calculate the 3D coordinate on unit sphere from the latitude and longitude.
 *
 * @param geo The latitude and longitude of the point.
 * @param v The 3D coordinate of the point.
 */
__device__ void _geoToVec3d(const LatLng *geo, Vec3d *v) {
  double r = cos(geo->lat);

  v->z = sin(geo->lat);
  v->x = cos(geo->lng) * r;
  v->y = sin(geo->lng) * r;
}
/**
 * Square of a number
 *
 * @param x The input number.
 * @return The square of the input number.
 */
__device__ double _square(double x) { return x * x; }

/**
 * Calculate the square of the distance between two 3D coordinates.
 *
 * @param v1 The first 3D coordinate.
 * @param v2 The second 3D coordinate.
 * @return The square of the distance between the given points.
 */
__device__ double _pointSquareDist(const Vec3d *v1, const Vec3d *v2) {
  return _square(v1->x - v2->x) + _square(v1->y - v2->y) +
         _square(v1->z - v2->z);
}

/**
 * Encodes a coordinate on the sphere to the corresponding icosahedral face and
 * containing 2D hex coordinates relative to that face center.
 *
 * @param g The spherical coordinates to encode.
 * @param res The desired H3 resolution for the encoding.
 * @param face The icosahedral face containing the spherical coordinates.
 * @param v The 2D hex coordinates of the cell containing the point.
 */
__device__ void _geoToHex2d(const LatLng *g, int res, int *face, Vec2d *v) {
  Vec3d v3d;
  _geoToVec3d(g, &v3d);

  // determine the icosahedron face
  *face = 0;
  double sqd = _pointSquareDist(&faceCenterPoint[0], &v3d);
  for (int f = 1; f < NUM_ICOSA_FACES; f++) {
    double sqdT = _pointSquareDist(&faceCenterPoint[f], &v3d);
    if (sqdT < sqd) {
      *face = f;
      sqd = sqdT;
    }
  }

  // cos(r) = 1 - 2 * sin^2(r/2) = 1 - 2 * (sqd / 4) = 1 - sqd/2
  double r = acos(1 - sqd / 2);

  if (r < EPSILON) {
    v->x = v->y = 0.0;
    return;
  }

  // now have face and r, now find CCW theta from CII i-axis
  double theta =
      _posAngleRads(faceAxesAzRadsCII[*face][0] -
                    _posAngleRads(_geoAzimuthRads(&faceCenterGeo[*face], g)));

  // adjust theta for Class III (odd resolutions)
  if (isResolutionClassIII(res))
    theta = _posAngleRads(theta - M_AP7_ROT_RADS);

  // perform gnomonic scaling of r
  r = tan(r);

  // scale for current resolution length u
  r /= RES0_U_GNOMONIC;
  for (int i = 0; i < res; i++)
    r *= M_SQRT7;

  // we now have (r, theta) in hex2d with theta ccw from x-axes

  // convert to local x,y
  v->x = r * cos(theta);
  v->y = r * sin(theta);
}

/**
 * Normalizes ijk coordinates by setting the components to the smallest possible
 * values. Works in place.
 *
 * @param c The ijk coordinates to normalize.
 */
__device__ void _ijkNormalize(CoordIJK *c) {
  // remove any negative values
  if (c->i < 0) {
    c->j -= c->i;
    c->k -= c->i;
    c->i = 0;
  }

  if (c->j < 0) {
    c->i -= c->j;
    c->k -= c->j;
    c->j = 0;
  }

  if (c->k < 0) {
    c->i -= c->k;
    c->j -= c->k;
    c->k = 0;
  }

  // remove the min value if needed
  int min = c->i;
  if (c->j < min)
    min = c->j;
  if (c->k < min)
    min = c->k;
  if (min > 0) {
    c->i -= min;
    c->j -= min;
    c->k -= min;
  }
}

/**
 * Determine the containing hex in ijk+ coordinates for a 2D cartesian
 * coordinate vector (from DGGRID).
 *
 * @param v The 2D cartesian coordinate vector.
 * @param h The ijk+ coordinates of the containing hex.
 */
__device__ void _hex2dToCoordIJK(const Vec2d *v, CoordIJK *h) {
  double a1, a2;
  double x1, x2;
  int m1, m2;
  double r1, r2;

  // quantize into the ij system and then normalize
  h->k = 0;

  a1 = fabs(v->x); // These used to be fabsl calls, but undefined on device
  a2 = fabs(v->y);

  // first do a reverse conversion
  x2 = a2 / M_SIN60;
  x1 = a1 + x2 / 2.0;

  // check if we have the center of a hex
  m1 = x1;
  m2 = x2;

  // otherwise round correctly
  r1 = x1 - m1;
  r2 = x2 - m2;

  if (r1 < 0.5) {
    if (r1 < 1.0 / 3.0) {
      if (r2 < (1.0 + r1) / 2.0) {
        h->i = m1;
        h->j = m2;
      } else {
        h->i = m1;
        h->j = m2 + 1;
      }
    } else {
      if (r2 < (1.0 - r1)) {
        h->j = m2;
      } else {
        h->j = m2 + 1;
      }

      if ((1.0 - r1) <= r2 && r2 < (2.0 * r1)) {
        h->i = m1 + 1;
      } else {
        h->i = m1;
      }
    }
  } else {
    if (r1 < 2.0 / 3.0) {
      if (r2 < (1.0 - r1)) {
        h->j = m2;
      } else {
        h->j = m2 + 1;
      }

      if ((2.0 * r1 - 1.0) < r2 && r2 < (1.0 - r1)) {
        h->i = m1;
      } else {
        h->i = m1 + 1;
      }
    } else {
      if (r2 < (r1 / 2.0)) {
        h->i = m1 + 1;
        h->j = m2;
      } else {
        h->i = m1 + 1;
        h->j = m2 + 1;
      }
    }
  }

  // now fold across the axes if necessary

  if (v->x < 0.0) {
    if ((h->j % 2) == 0) // even
    {
      long long int axisi = h->j / 2;
      long long int diff = h->i - axisi;
      h->i = h->i - 2.0 * diff;
    } else {
      long long int axisi = (h->j + 1) / 2;
      long long int diff = h->i - axisi;
      h->i = h->i - (2.0 * diff + 1);
    }
  }

  if (v->y < 0.0) {
    h->i = h->i - (2 * h->j + 1) / 2;
    h->j = -1 * h->j;
  }

  _ijkNormalize(h);
}

/** @brief Find base cell given FaceIJK.
 *
 * Given the face number and a resolution 0 ijk+ coordinate in that face's
 * face-centered ijk coordinate system, return the base cell located at that
 * coordinate.
 *
 * Valid ijk+ lookup coordinates are from (0, 0, 0) to (2, 2, 2).
 */
__device__ int _faceIjkToBaseCell(const FaceIJK *h) {
  return faceIjkBaseCells[h->face][h->coord.i][h->coord.j][h->coord.k].baseCell;
}

/**
 * Encodes a coordinate on the sphere to the FaceIJK address of the containing
 * cell at the specified resolution.
 *
 * @param g The spherical coordinates to encode.
 * @param res The desired H3 resolution for the encoding.
 * @param h The FaceIJK address of the containing cell at resolution res.
 */
__device__ void _geoToFaceIjk(const LatLng *g, int res, FaceIJK *h) {
  // first convert to hex2d
  Vec2d v;
  _geoToHex2d(g, res, &h->face, &v);

  // then convert to ijk+
  _hex2dToCoordIJK(&v, &h->coord);
}

/**
 * Add two ijk coordinates.
 *
 * @param h1 The first set of ijk coordinates.
 * @param h2 The second set of ijk coordinates.
 * @param sum The sum of the two sets of ijk coordinates.
 */
__device__ void _ijkAdd(const CoordIJK *h1, const CoordIJK *h2, CoordIJK *sum) {
  sum->i = h1->i + h2->i;
  sum->j = h1->j + h2->j;
  sum->k = h1->k + h2->k;
}

/**
 * Subtract two ijk coordinates.
 *
 * @param h1 The first set of ijk coordinates.
 * @param h2 The second set of ijk coordinates.
 * @param diff The difference of the two sets of ijk coordinates (h1 - h2).
 */
__device__ void _ijkSub(const CoordIJK *h1, const CoordIJK *h2,
                        CoordIJK *diff) {
  diff->i = h1->i - h2->i;
  diff->j = h1->j - h2->j;
  diff->k = h1->k - h2->k;
}

/**
 * Uniformly scale ijk coordinates by a scalar. Works in place.
 *
 * @param c The ijk coordinates to scale.
 * @param factor The scaling factor.
 */
__device__ void _ijkScale(CoordIJK *c, int factor) {
  c->i *= factor;
  c->j *= factor;
  c->k *= factor;
}

/**
 * Returns whether or not two ijk coordinates contain exactly the same
 * component values.
 *
 * @param c1 The first set of ijk coordinates.
 * @param c2 The second set of ijk coordinates.
 * @return 1 if the two addresses match, 0 if they do not.
 */
__device__ int _ijkMatches(const CoordIJK *c1, const CoordIJK *c2) {
  return (c1->i == c2->i && c1->j == c2->j && c1->k == c2->k);
}

/**
 * Find the normalized ijk coordinates of the indexing parent of a cell in a
 * counter-clockwise aperture 7 grid. Works in place.
 *
 * @param ijk The ijk coordinates.
 */
__device__ void _upAp7(CoordIJK *ijk) {
  // convert to CoordIJ
  int i = ijk->i - ijk->k;
  int j = ijk->j - ijk->k;

  ijk->i = (int)round((3 * i - j) / 7.0);
  ijk->j = (int)round((i + 2 * j) / 7.0);
  ijk->k = 0;
  _ijkNormalize(ijk);
}

/**
 * Find the normalized ijk coordinates of the indexing parent of a cell in a
 * clockwise aperture 7 grid. Works in place.
 *
 * @param ijk The ijk coordinates.
 */
__device__ void _upAp7r(CoordIJK *ijk) {
  // convert to CoordIJ
  int i = ijk->i - ijk->k;
  int j = ijk->j - ijk->k;

  ijk->i = (int)round((2 * i + j) / 7.0);
  ijk->j = (int)round((3 * j - i) / 7.0);
  ijk->k = 0;
  _ijkNormalize(ijk);
}

/**
 * Find the normalized ijk coordinates of the hex centered on the indicated
 * hex at the next finer aperture 7 counter-clockwise resolution. Works in
 * place.
 *
 * @param ijk The ijk coordinates.
 */
__device__ void _downAp7(CoordIJK *ijk) {
  // res r unit vectors in res r+1
  CoordIJK iVec = {3, 0, 1};
  CoordIJK jVec = {1, 3, 0};
  CoordIJK kVec = {0, 1, 3};

  _ijkScale(&iVec, ijk->i);
  _ijkScale(&jVec, ijk->j);
  _ijkScale(&kVec, ijk->k);

  _ijkAdd(&iVec, &jVec, ijk);
  _ijkAdd(ijk, &kVec, ijk);

  _ijkNormalize(ijk);
}

/**
 * Find the normalized ijk coordinates of the hex centered on the indicated
 * hex at the next finer aperture 7 clockwise resolution. Works in place.
 *
 * @param ijk The ijk coordinates.
 */
__device__ void _downAp7r(CoordIJK *ijk) {
  // res r unit vectors in res r+1
  CoordIJK iVec = {3, 1, 0};
  CoordIJK jVec = {0, 3, 1};
  CoordIJK kVec = {1, 0, 3};

  _ijkScale(&iVec, ijk->i);
  _ijkScale(&jVec, ijk->j);
  _ijkScale(&kVec, ijk->k);

  _ijkAdd(&iVec, &jVec, ijk);
  _ijkAdd(ijk, &kVec, ijk);

  _ijkNormalize(ijk);
}

// /**
//  * Determines the H3 digit corresponding to a unit vector in ijk coordinates.
//  *
//  * @param ijk The ijk coordinates; must be a unit vector.
//  * @return The H3 digit (0-6) corresponding to the ijk unit vector, or
//  * INVALID_DIGIT on failure.
//  */
// __device__ Direction _unitIjkToDigit(const CoordIJK *ijk) {
//     CoordIJK c = *ijk;
//     _ijkNormalize(&c);

//     Direction digit = INVALID_DIGIT;
//     for (Direction i = CENTER_DIGIT; i < NUM_DIGITS; i++) {
//         if (_ijkMatches(&c, &UNIT_VECS[i])) {
//             digit = i;
//             break;
//         }
//     }

//     return digit;
// }

/**
 * Determines the H3 digit corresponding to a unit vector in ijk coordinates.
 *
 * @param ijk The ijk coordinates; must be a unit vector.
 * @return The H3 digit (0-6) corresponding to the ijk unit vector, or
 * INVALID_DIGIT on failure.
 */
__device__ Direction _unitIjkToDigit(const CoordIJK *ijk) {
  CoordIJK c = *ijk;
  _ijkNormalize(&c);

  // TODO: Replicate enum loop
  // CENTER_DIGIT = 0,
  Direction digit = CENTER_DIGIT;
  if (_ijkMatches(&c, &UNIT_VECS[digit])) {
    return digit;
  }
  // K_AXES_DIGIT = 1,
  digit = K_AXES_DIGIT;
  if (_ijkMatches(&c, &UNIT_VECS[digit])) {
    return digit;
  }
  // J_AXES_DIGIT = 2,
  digit = J_AXES_DIGIT;
  if (_ijkMatches(&c, &UNIT_VECS[digit])) {
    return digit;
  }
  // JK_AXES_DIGIT = J_AXES_DIGIT | K_AXES_DIGIT, /* 3 */
  digit = JK_AXES_DIGIT;
  if (_ijkMatches(&c, &UNIT_VECS[digit])) {
    return digit;
  }
  // I_AXES_DIGIT = 4,
  digit = I_AXES_DIGIT;
  if (_ijkMatches(&c, &UNIT_VECS[digit])) {
    return digit;
  }
  // IK_AXES_DIGIT = I_AXES_DIGIT | K_AXES_DIGIT, /* 5 */
  digit = IK_AXES_DIGIT;
  if (_ijkMatches(&c, &UNIT_VECS[digit])) {
    return digit;
  }
  // IJ_AXES_DIGIT = I_AXES_DIGIT | J_AXES_DIGIT, /* 6 */
  digit = IJ_AXES_DIGIT;
  if (_ijkMatches(&c, &UNIT_VECS[digit])) {
    return digit;
  }

  return INVALID_DIGIT;
}

/** @brief Find base cell given FaceIJK.
 *
 * Given the face number and a resolution 0 ijk+ coordinate in that face's
 * face-centered ijk coordinate system, return the number of 60' ccw rotations
 * to rotate into the coordinate system of the base cell at that coordinates.
 *
 * Valid ijk+ lookup coordinates are from (0, 0, 0) to (2, 2, 2).
 */
__device__ int _faceIjkToBaseCellCCWrot60(const FaceIJK *h) {
  return faceIjkBaseCells[h->face][h->coord.i][h->coord.j][h->coord.k].ccwRot60;
}

/** @brief Return whether or not the indicated base cell is a pentagon. */
__device__ int _isBaseCellPentagon(int baseCell) {
  if (baseCell < 0 || baseCell >= NUM_BASE_CELLS) {
    // Base cells less than zero can not be represented in an index
    return false;
  }
  return baseCellData[baseCell].isPentagon;
}

/**
 * Returns the highest resolution non-zero digit in an H3Index.
 * @param h The H3Index.
 * @return The highest resolution non-zero digit in the H3Index.
 */
__device__ Direction _h3LeadingNonZeroDigit(H3Index h) {
  for (int r = 1; r <= H3_GET_RESOLUTION(h); r++)
    if (H3_GET_INDEX_DIGIT(h, r))
      return H3_GET_INDEX_DIGIT(h, r);

  // if we're here it's all 0's
  return CENTER_DIGIT;
}

/** @brief Return whether or not the tested face is a cw offset face.
 */
__device__ bool _baseCellIsCwOffset(int baseCell, int testFace) {
  return baseCellData[baseCell].cwOffsetPent[0] == testFace ||
         baseCellData[baseCell].cwOffsetPent[1] == testFace;
}

/**
 * Rotates indexing digit 60 degrees counter-clockwise. Returns result.
 *
 * @param digit Indexing digit (between 1 and 6 inclusive)
 */
__device__ Direction _rotate60ccw(Direction digit) {
  switch (digit) {
  case K_AXES_DIGIT:
    return IK_AXES_DIGIT;
  case IK_AXES_DIGIT:
    return I_AXES_DIGIT;
  case I_AXES_DIGIT:
    return IJ_AXES_DIGIT;
  case IJ_AXES_DIGIT:
    return J_AXES_DIGIT;
  case J_AXES_DIGIT:
    return JK_AXES_DIGIT;
  case JK_AXES_DIGIT:
    return K_AXES_DIGIT;
  default:
    return digit;
  }
}
/**
 * Rotates indexing digit 60 degrees clockwise. Returns result.
 *
 * @param digit Indexing digit (between 1 and 6 inclusive)
 */
__device__ Direction _rotate60cw(Direction digit) {
  switch (digit) {
  case K_AXES_DIGIT:
    return JK_AXES_DIGIT;
  case JK_AXES_DIGIT:
    return J_AXES_DIGIT;
  case J_AXES_DIGIT:
    return IJ_AXES_DIGIT;
  case IJ_AXES_DIGIT:
    return I_AXES_DIGIT;
  case I_AXES_DIGIT:
    return IK_AXES_DIGIT;
  case IK_AXES_DIGIT:
    return K_AXES_DIGIT;
  default:
    return digit;
  }
}

/**
 * Rotate an H3Index 60 degrees counter-clockwise.
 * @param h The H3Index.
 */
__device__ H3Index _h3Rotate60ccw(H3Index h) {
  for (int r = 1, res = H3_GET_RESOLUTION(h); r <= res; r++) {
    Direction oldDigit = H3_GET_INDEX_DIGIT(h, r);
    H3_SET_INDEX_DIGIT(h, r, _rotate60ccw(oldDigit));
  }

  return h;
}

/**
 * Rotate an H3Index 60 degrees clockwise.
 * @param h The H3Index.
 */
__device__ H3Index _h3Rotate60cw(H3Index h) {
  for (int r = 1, res = H3_GET_RESOLUTION(h); r <= res; r++) {
    H3_SET_INDEX_DIGIT(h, r, _rotate60cw(H3_GET_INDEX_DIGIT(h, r)));
  }

  return h;
}

/**
 * Rotate an H3Index 60 degrees counter-clockwise about a pentagonal center.
 * @param h The H3Index.
 */
__device__ H3Index _h3RotatePent60ccw(H3Index h) {
  // rotate in place; skips any leading 1 digits (k-axis)

  int foundFirstNonZeroDigit = 0;
  for (int r = 1, res = H3_GET_RESOLUTION(h); r <= res; r++) {
    // rotate this digit
    H3_SET_INDEX_DIGIT(h, r, _rotate60ccw(H3_GET_INDEX_DIGIT(h, r)));

    // look for the first non-zero digit so we
    // can adjust for deleted k-axes sequence
    // if necessary
    if (!foundFirstNonZeroDigit && H3_GET_INDEX_DIGIT(h, r) != 0) {
      foundFirstNonZeroDigit = 1;

      // adjust for deleted k-axes sequence
      if (_h3LeadingNonZeroDigit(h) == K_AXES_DIGIT)
        h = _h3Rotate60ccw(h);
    }
  }
  return h;
}

/**
 * Convert an FaceIJK address to the corresponding H3Index.
 * @param fijk The FaceIJK address.
 * @param res The cell resolution.
 * @return The encoded H3Index (or H3_NULL on failure).
 */
__device__ H3Index _faceIjkToH3(const FaceIJK *fijk, int res) {
  // initialize the index
  H3Index h = H3_INIT;
  H3_SET_MODE(h, H3_CELL_MODE);
  H3_SET_RESOLUTION(h, res);

  // check for res 0/base cell
  if (res == 0) {
    if (fijk->coord.i > MAX_FACE_COORD || fijk->coord.j > MAX_FACE_COORD ||
        fijk->coord.k > MAX_FACE_COORD) {
      // out of range input
      return H3_NULL;
    }

    H3_SET_BASE_CELL(h, _faceIjkToBaseCell(fijk));
    return h;
  }

  // we need to find the correct base cell FaceIJK for this H3 index;
  // start with the passed in face and resolution res ijk coordinates
  // in that face's coordinate system
  FaceIJK fijkBC = *fijk;

  // return h;
  // build the H3Index from finest res up
  // adjust r for the fact that the res 0 base cell offsets the indexing
  // digits
  CoordIJK *ijk = &fijkBC.coord;
  for (int r = res - 1; r >= 0; r--) {
    CoordIJK lastIJK = *ijk;
    CoordIJK lastCenter;
    if (isResolutionClassIII(r + 1)) {
      // rotate ccw
      _upAp7(ijk);
      lastCenter = *ijk;
      _downAp7(&lastCenter);
    } else {
      // rotate cw
      _upAp7r(ijk);
      lastCenter = *ijk;
      _downAp7r(&lastCenter);
    }

    CoordIJK diff;
    _ijkSub(&lastIJK, &lastCenter, &diff);
    _ijkNormalize(&diff);

    H3_SET_INDEX_DIGIT(h, r + 1, _unitIjkToDigit(&diff));
  }

  // fijkBC should now hold the IJK of the base cell in the
  // coordinate system of the current face

  if (fijkBC.coord.i > MAX_FACE_COORD || fijkBC.coord.j > MAX_FACE_COORD ||
      fijkBC.coord.k > MAX_FACE_COORD) {
    // out of range input
    return H3_NULL;
  }

  // lookup the correct base cell
  int baseCell = _faceIjkToBaseCell(&fijkBC);
  H3_SET_BASE_CELL(h, baseCell);

  // rotate if necessary to get canonical base cell orientation
  // for this base cell
  int numRots = _faceIjkToBaseCellCCWrot60(&fijkBC);
  if (_isBaseCellPentagon(baseCell)) {
    // force rotation out of missing k-axes sub-sequence
    if (_h3LeadingNonZeroDigit(h) == K_AXES_DIGIT) {
      // check for a cw/ccw offset face; default is ccw
      if (_baseCellIsCwOffset(baseCell, fijkBC.face)) {
        h = _h3Rotate60cw(h);
      } else {
        h = _h3Rotate60ccw(h);
      }
    }

    for (int i = 0; i < numRots; i++)
      h = _h3RotatePent60ccw(h);
  } else {
    for (int i = 0; i < numRots; i++) {
      h = _h3Rotate60ccw(h);
    }
  }

  return h;
}

/**
 * Encodes a coordinate on the sphere to the H3 index of the containing cell at
 * the specified resolution.
 *
 * Returns 0 on invalid input.
 *
 * @param g The spherical coordinates to encode.
 * @param res The desired H3 resolution for the encoding.
 * @param out The encoded H3Index.
 * @returns E_SUCCESS (0) on success, another value otherwise
 */
__device__ H3Error latLngToCell(const LatLng *g, int res, H3Index *out) {
  if (res < 0 || res > MAX_H3_RES) {
    return E_RES_DOMAIN;
  }
  if (!isfinite(g->lat) || !isfinite(g->lng)) {
    return E_LATLNG_DOMAIN;
  }

  FaceIJK fijk;
  _geoToFaceIjk(g, res, &fijk);
  *out = _faceIjkToH3(&fijk, res);
  if (*out) {
    return E_SUCCESS;
  } else {
    return E_FAILED;
  }
}

void __global__ kernel_h3(float *lat_device, float *lon_device,
                          uint64_t *idx_device, int length, int resolution) {
  int gid = threadIdx.x + blockDim.x * blockIdx.x;

  LatLng location;
  H3Index indexed;
  while (gid < length) {

    location.lat = degsToRads(lat_device[gid]);
    location.lng = degsToRads(lon_device[gid]);

    if (latLngToCell(&location, resolution, &indexed) != E_SUCCESS) {
      idx_device[gid] = H3_NULL;
    } else {
      idx_device[gid] = indexed;
    }
    gid += blockDim.x * gridDim.x;
  }
  __syncthreads();
}

void __global__ kernel_h3_unified(float *data_device, uint64_t *idx_device,
                                  int length, int resolution) {
  int gid = threadIdx.x + blockDim.x * blockIdx.x;

  LatLng location;
  H3Index indexed;
  while (gid < length) {
    int idx = gid * 2;
    location.lat = degsToRads(data_device[idx]);
    location.lng = degsToRads(data_device[idx + 1]);

    if (latLngToCell(&location, resolution, &indexed) != E_SUCCESS) {
      idx_device[gid] = H3_NULL;
    } else {
      idx_device[gid] = indexed;
    }
    gid += blockDim.x * gridDim.x;
  }
  __syncthreads();
}

#endif