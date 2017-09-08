from libcpp cimport bool
from libcpp.map cimport map
from libcpp.string cimport string
from eigency.core cimport *

#===============================================================================
# tmm.h
#===============================================================================
        
cdef extern from "tmm.h" namespace "TmmModel":
    
    cdef enum ParamTypeCpp "TmmModel::ParamType":
        WL,
        BETA,
        ENH_OPT_REL,
        ENH_OPT_MAX_ITERS,
        ENH_INITIAL_STEP,
        LAYER_D,
        LAYER_N,
        LAYER_NX,
        LAYER_NY,
        LAYER_NZ,
        LAYER_PSI,
        LAYER_XI,
        LAYER_MAT_NX,
        LAYER_MAT_NY,
        LAYER_MAT_NZ,
        NOT_DEFINED
    
    #---------------------------------------------------------------------------
        
    cdef enum WaveDirectionCpp "TmmModel::WaveDirection":
        WD_FORWARD,
        WD_BACKWARD,
        WD_BOTH
    
    #---------------------------------------------------------------------------
    
    cdef cppclass ParamCpp "TmmModel::Param":
            ParamCpp() except +
            ParamCpp(ParamTypeCpp pType) except +
            ParamCpp(ParamTypeCpp pType_, int layerId_) except +
    
    #--------------------------------------------------------------------------- 
    
    cdef cppclass PositionSettingsCpp "TmmModel::PositionSettings":
        PositionSettingsCpp() except +
        PositionSettingsCpp(double polCoef1, double polCoef2, int interfaceId_, double distFromInterface_) except +
            
    #--------------------------------------------------------------------------- 

    cdef cppclass SweepResCpp "TmmModel::SweepRes":
        map[string, ArrayXcd] GetComplexMap() except +
        map[string, ArrayXd] GetDoubleMap() except +
    
    #---------------------------------------------------------------------------
    
    cdef cppclass EMFieldsCpp "TmmModel::EMFields":
        ArrayXcd E
        ArrayXcd H
    
    #---------------------------------------------------------------------------
    
    cdef cppclass EMFieldsListCpp "TmmModel::EMFieldsList":
        MatrixXcd E
        MatrixXcd H
    
    #---------------------------------------------------------------------------

    cdef cppclass TmmCpp "TmmModel::Tmm":
        Tmm() except +
        
        void SetParam(ParamCpp ParamCpp, int value) except +
        void SetParam(ParamCpp ParamCpp, double value) except +
        void SetParam(ParamCpp ParamCpp, double complex value) except +
        
        int GetParamInt(ParamCpp ParamCpp) except +
        double GetParamDouble(ParamCpp ParamCpp) except + 
        double complex GetParamComplex(ParamCpp ParamCpp) except +
        
        void AddIsotropicLayer(double d, double complex n) except +
        #//void AddIsotropicLayer(double d, boost::python::object &materialClass) except +
        void AddLayer(double d, double complex nx, double complex ny, double complex nz, double psi, double xi) except +
        #//void AddLayer(double d, boost::python::object &matX, boost::python::object &matY, boost::python::object &matZ, double psi, double xi) except +
        void ClearLayers() except +
        
        Matrix4d GetIntensityMatrix() except +
        Matrix4cd GetAmplitudeMatrix() except +
        SweepResCpp Sweep(ParamCpp sweepParamCpp, Map[ArrayXd] sweepValues, PositionSettingsCpp enhpos, int alphasLayer) except +
        
        EMFieldsListCpp CalcFields1D(Map[ArrayXd] xs, Map[Array2d] polarization, WaveDirectionCpp waveDirection) except +
        EMFieldsCpp CalcFieldsAtInterface(PositionSettingsCpp pos, WaveDirectionCpp waveDirection) except +
        #double OptimizeEnhancement(vector<ParamCpp> optParamCpps, VectorXd optInitial, PositionSettings pos) except +
        #//double OptimizeEnhancementPython(boost::python::list optParams, VectorXd optInitial, PositionSettings pos) except +

