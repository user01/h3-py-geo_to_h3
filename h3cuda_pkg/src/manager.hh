
class latLngToCell_Distinct {
  float *lat_d;
  float *lat_h;
  float *lon_d;
  float *lon_h;
  uint64_t *idx_d;
  uint64_t *idx_h;

  int length; // all arrays of identical shape

public:
  latLngToCell_Distinct(float *lat_host_, float *lon_host_, uint64_t *idx_host_,
                        int length_, int resolution, uint blocks, uint threads);
  ~latLngToCell_Distinct(); // destructor
};

class latLngToCell_Unified {

public:
  latLngToCell_Unified(float *data_host_, uint64_t *idx_host_, int length_,
                       int resolution, uint blocks, uint threads);
  ~latLngToCell_Unified(); // destructor
};
