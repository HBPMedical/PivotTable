select patient_num, imageuid
MAX(CASE WHEN concept_cd = 'acquisition_plane' then tval_char ELSE NULL END) as "acquisition_plane",
MAX(CASE WHEN concept_cd = 'slice_thickness' then nval_num ELSE NULL END) as "slice_thickness",
MAX(CASE WHEN concept_cd = 'pixel_spacing_x' then nval_num ELSE NULL END) as "pixel_spacing_x",
MAX(CASE WHEN concept_cd = 'flip_angle' then nval_num ELSE NULL END) as "flip_angle",
MAX(CASE WHEN concept_cd = 'acquisition_type' then nval_num ELSE NULL END) as "acquisition_type",
MAX(CASE WHEN concept_cd = 'matrix_x' then nval_num ELSE NULL END) as "matrix_x",
MAX(CASE WHEN concept_cd = 'te' then nval_num ELSE NULL END) as "te",
MAX(CASE WHEN concept_cd = 'pulse_sequence' then tval_char ELSE NULL END) as "pulse_sequence",
MAX(CASE WHEN concept_cd = 'tr' then nval_num ELSE NULL END) as "tr",
MAX(CASE WHEN concept_cd = 'matrix_y' then nval_num ELSE NULL END) as "matrix_y",
MAX(CASE WHEN concept_cd = 'ti' then nval_num ELSE NULL END) as "ti",
MAX(CASE WHEN concept_cd = 'matrix_z' then nval_num ELSE NULL END) as "matrix_z",
MAX(CASE WHEN concept_cd = 'pixel_spacing_y' then nval_num ELSE NULL END) as "pixel_spacing_y",
MAX(CASE WHEN concept_cd = 'weighting' then tval_char ELSE NULL END) as "weighting",
MAX(CASE WHEN concept_cd = 'coil' then tval_char ELSE NULL END) as "coil"
from observation_fact
group by patient_num