#!/usr/bin/env bash

set -e
set -x
shopt -s dotglob

readonly name="visit"
readonly ownership="VisIt Upstream <kwrobot@kitware.com>"
readonly subtree="Library/VisItLib"
readonly repo="https://gitlab.kitware.com/third-party/visit.git"
readonly tag="for/paraview-20200205-trunk-r34006"

readonly paths="
COPYRIGHT
.gitattributes
README.kitware.md
CMakeLists.paraview.txt

CMake/testFStream.cxx
CMake/TestSocklenT.c
CMake/VisItCommon.cmake

avt/Database/Database/avtDatabase.*
avt/Database/Database/avtDatabaseFactory.*
avt/Database/Database/avtDatasetCollection.*
avt/Database/Database/avtDatasetDatabase.*
avt/Database/Database/avtFileDescriptorManager.*
avt/Database/Database/avtGenericDatabase.*
avt/Database/Database/avtIOInformation.*
avt/Database/Database/avtSILGenerator.*
avt/Database/Database/avtSourceFromDatabase.*
avt/Database/Database/avtTransformManager.*
avt/Database/Database/avtVariableCache.*
avt/Database/Database/database_exports.h
avt/Database/Ghost/StructuredBoundary.C
avt/Database/Ghost/avtDomainBoundaries.*
avt/Database/Ghost/avtDomainNesting.h
avt/Database/Ghost/avtIsenburgSGG.*
avt/Database/Ghost/avtLocalStructuredDomainBoundaries.*
avt/Database/Ghost/avtNekDomainBoundaries.*
avt/Database/Ghost/avtStreamingGhostGenerator.*
avt/Database/Ghost/avtStructuredDomainBoundaries.*
avt/Database/Ghost/avtStructuredDomainNesting.*
avt/Database/Ghost/avtUnstructuredDomainBoundaries.*
avt/Database/Ghost/avtUnstructuredPointBoundaries.*
avt/Database/Formats/avtMTMDFileFormat.*
avt/Database/Formats/avtSTMDFileFormat.h
avt/Database/Formats/avtSTSDFileFormatInterface.h
avt/Database/Formats/avtSTMDFileFormatInterface.h
avt/Database/Formats/avtMTMDFileFormatInterface.*
avt/Database/Formats/avtFileFormat.*
avt/Database/Formats/avtSTMDFileFormatInterface.*
avt/Database/Formats/avtSTSDFileFormat.h
avt/Database/Formats/avtMTSDFileFormat.*
avt/Database/Formats/avtSTSDFileFormatInterface.*
avt/Database/Formats/avtFileFormat.h
avt/Database/Formats/avtMTMDFileFormat.h
avt/Database/Formats/avtMTSDFileFormatInterface.*
avt/Database/Formats/avtMTSDFileFormatInterface.h
avt/Database/Formats/avtSTSDFileFormat.*
avt/Database/Formats/avtMTMDFileFormatInterface.h
avt/Database/Formats/avtFileFormatInterface.*
avt/Database/Formats/avtSTMDFileFormat.*
avt/Database/Formats/avtFileFormatInterface.h
avt/Database/Formats/avtMTSDFileFormat.h
avt/Database/CMakeLists.txt

avt/DBAtts/SIL/avtSIL.*
avt/DBAtts/SIL/avtSILArray.*
avt/DBAtts/SIL/avtSILCollection.*
avt/DBAtts/SIL/avtSILEnumeratedNamespace.*
avt/DBAtts/SIL/avtSILMatrix.*
avt/DBAtts/SIL/avtSILNamespace.*
avt/DBAtts/SIL/avtSILRangeNamespace.*
avt/DBAtts/SIL/avtSILRestriction.*
avt/DBAtts/SIL/avtSILRestrictionTraverser.*
avt/DBAtts/SIL/avtSILSet.*
avt/DBAtts/MetaData/avtArrayMetaData.*
avt/DBAtts/MetaData/avtBaseVarMetaData.*
avt/DBAtts/MetaData/avtCurveMetaData.*
avt/DBAtts/MetaData/avtDatabaseMetaData.*
avt/DBAtts/MetaData/avtDefaultPlotMetaData.*
avt/DBAtts/MetaData/avtExpressionTypeConversions.*
avt/DBAtts/MetaData/avtLabelMetaData.*
avt/DBAtts/MetaData/avtMatSpeciesMetaData.*
avt/DBAtts/MetaData/avtMaterialMetaData.*
avt/DBAtts/MetaData/avtMeshMetaData.*
avt/DBAtts/MetaData/avtScalarMetaData.*
avt/DBAtts/MetaData/avtSimulationCommandSpecification.*
avt/DBAtts/MetaData/avtSimulationInformation.*
avt/DBAtts/MetaData/avtSpeciesMetaData.*
avt/DBAtts/MetaData/avtSubsetsMetaData.*
avt/DBAtts/MetaData/avtSymmetricTensorMetaData.*
avt/DBAtts/MetaData/avtTensorMetaData.*
avt/DBAtts/MetaData/avtTypes.*
avt/DBAtts/MetaData/avtVarMetaData.*
avt/DBAtts/MetaData/avtVectorMetaData.*
avt/DBAtts/MetaData/dbatts_exports.h
avt/DBAtts/CMakeLists.txt

avt/Math/avtMatrix.*
avt/Math/avtMatrix.h
avt/Math/avtPolynomial.*
avt/Math/avtVector.*
avt/Math/math_exports.h
avt/Math/CMakeLists.txt

avt/Pipeline/Pipeline/ThreadPool.*
avt/Pipeline/Pipeline/avtContract.*
avt/Pipeline/Pipeline/avtDataObjectReader.*
avt/Pipeline/Pipeline/avtDataObjectString.*
avt/Pipeline/Pipeline/avtDataObjectWriter.*
avt/Pipeline/Pipeline/avtDataRequest.*
avt/Pipeline/Pipeline/avtDataSetReader.*
avt/Pipeline/Pipeline/avtDataSetWriter.*
avt/Pipeline/Pipeline/avtDebugDumpOptions.*
avt/Pipeline/Pipeline/avtExecutionManager.*
avt/Pipeline/Pipeline/avtImageReader.*
avt/Pipeline/Pipeline/avtImageWriter.*
avt/Pipeline/Pipeline/avtMemory.*
avt/Pipeline/Pipeline/avtNamedSelection.*
avt/Pipeline/Pipeline/avtNamedSelectionExtension.*
avt/Pipeline/Pipeline/avtNamedSelectionManager.*
avt/Pipeline/Pipeline/avtNullDataReader.*
avt/Pipeline/Pipeline/avtNullDataWriter.*
avt/Pipeline/Pipeline/avtParallel.*
avt/Pipeline/Pipeline/avtParallelContext.*
avt/Pipeline/Pipeline/avtWebpage.*
avt/Pipeline/Sinks/avtDataObjectSink.*
avt/Pipeline/Sinks/avtDatabaseWriter.*
avt/Pipeline/Sinks/avtDatasetSink.*
avt/Pipeline/Sinks/avtImageSink.*
avt/Pipeline/Sinks/avtMultipleInputSink.*
avt/Pipeline/Sinks/avtNullDataSink.*
avt/Pipeline/Sinks/avtTerminatingDatasetSink.*
avt/Pipeline/Sinks/avtTerminatingImageSink.*
avt/Pipeline/Sinks/avtTerminatingNullDataSink.*
avt/Pipeline/Sinks/avtTerminatingSink.*
avt/Pipeline/Data/avtCallback.*
avt/Pipeline/Data/avtCommonDataFunctions.*
avt/Pipeline/Data/avtDataAttributes.*
avt/Pipeline/Data/avtDataObject.*
avt/Pipeline/Data/avtDataObjectInformation.*
avt/Pipeline/Data/avtDataRepresentation.*
avt/Pipeline/Data/avtDataSelection.h
avt/Pipeline/Data/avtDataTree.*
avt/Pipeline/Data/avtDataValidity.*
avt/Pipeline/Data/avtDataset.*
avt/Pipeline/Data/avtDatasetExaminer.*
avt/Pipeline/Data/avtDatasetVerifier.*
avt/Pipeline/Data/avtDynamicAttribute.*
avt/Pipeline/Data/avtExtents.*
avt/Pipeline/Data/avtFacelist.*
avt/Pipeline/Data/avtGhostData.h
avt/Pipeline/Data/avtHistogramSpecification.*
avt/Pipeline/Data/avtIdentifierSelection.*
avt/Pipeline/Data/avtImage.*
avt/Pipeline/Data/avtImageRepresentation.*
avt/Pipeline/Data/avtIntervalTree.*
avt/Pipeline/Data/avtIsolevelsSelection.*
avt/Pipeline/Data/avtLogicalSelection.*
avt/Pipeline/Data/avtMaterial.*
avt/Pipeline/Data/avtMetaData.*
avt/Pipeline/Data/avtMixedVariable.*
avt/Pipeline/Data/avtMultiresSelection.*
avt/Pipeline/Data/avtNullData.*
avt/Pipeline/Data/avtPlaneSelection.*
avt/Pipeline/Data/avtPointSelection.*
avt/Pipeline/Data/avtResampleSelection.*
avt/Pipeline/Data/avtResolutionSelection.*
avt/Pipeline/Data/avtSpatialBoxSelection.*
avt/Pipeline/Data/avtSpecies.*
avt/Pipeline/Data/pipeline_exports.h
avt/Pipeline/Sources/avtDataObjectSource.*
avt/Pipeline/Sources/avtDatasetSource.*
avt/Pipeline/Sources/avtImageSource.*
avt/Pipeline/Sources/avtInlinePipelineSource.*
avt/Pipeline/Sources/avtNullDataSource.*
avt/Pipeline/Sources/avtOriginatingDatasetSource.*
avt/Pipeline/Sources/avtOriginatingImageSource.*
avt/Pipeline/Sources/avtOriginatingNullDataSource.*
avt/Pipeline/Sources/avtOriginatingSource.*
avt/Pipeline/Sources/avtQueryableSource.*
avt/Pipeline/Sources/avtSourceFromAVTDataset.*
avt/Pipeline/CMakeLists.txt
avt/Pipeline/AbstractFilters/avtCompactTreeFilter.*
avt/Pipeline/AbstractFilters/avtDataObjectToDatasetFilter.*
avt/Pipeline/AbstractFilters/avtDataTreeIterator.*
avt/Pipeline/AbstractFilters/avtDatasetToDataObjectFilter.*
avt/Pipeline/AbstractFilters/avtDatasetToDatasetFilter.*
avt/Pipeline/AbstractFilters/avtFacadeFilter.*
avt/Pipeline/AbstractFilters/avtFilter.*
avt/Pipeline/AbstractFilters/avtPluginFilter.h
avt/Pipeline/AbstractFilters/avtPluginSIMODataTreeIterator.h
avt/Pipeline/AbstractFilters/avtPluginStructuredChunkDataTreeIterator.*
avt/Pipeline/AbstractFilters/avtSIMODataTreeIterator.*

avt/VisWindow/VisWindow/VisWindowTypes.h

avt/CMakeLists.txt

common/comm/BadHostException.*
common/comm/BufferConnection.*
common/comm/CancelledConnectException.h
common/comm/Connection.*
common/comm/CouldNotConnectException.h
common/comm/DConvert.C
common/comm/FConvert.C
common/comm/IConvert.C
common/comm/IncompatibleSecurityTokenException.h
common/comm/IncompatibleVersionException.h
common/comm/LConvert.C
common/comm/LostConnectionException.h
common/comm/TypeRepresentation.*
common/comm/comm_exports.h
common/comm/convert.h

common/Exceptions/Database/BadPermissionException.*
common/Exceptions/Database/DBYieldedNoDataException.*
common/Exceptions/Database/DatabaseException.h
common/Exceptions/Database/FileDoesNotExistException.*
common/Exceptions/Database/InvalidDBTypeException.*
common/Exceptions/Database/InvalidFilesException.*
common/Exceptions/Database/InvalidSourceException.*
common/Exceptions/Database/InvalidTimeStepException.*
common/Exceptions/Database/InvalidVariableException.*
common/Exceptions/Database/InvalidZoneTypeException.*
common/Exceptions/Database/NonCompliantException.*
common/Exceptions/Database/NonCompliantFileException.*
common/Exceptions/Database/PointerNotInCacheException.*
common/Exceptions/Database/SiloException.*
common/Exceptions/Pipeline/AbortException.*
common/Exceptions/Pipeline/BadCellException.*
common/Exceptions/Pipeline/BadDomainException.*
common/Exceptions/Pipeline/BadIndexException.*
common/Exceptions/Pipeline/BadNodeException.*
common/Exceptions/Pipeline/BadVectorException.*
common/Exceptions/Pipeline/ExpressionException.*
common/Exceptions/Pipeline/GhostCellException.*
common/Exceptions/Pipeline/ImproperUseException.*
common/Exceptions/Pipeline/IncompatibleDomainListsException.*
common/Exceptions/Pipeline/IntervalTreeNotCalculatedException.*
common/Exceptions/Pipeline/InvalidCategoryException.*
common/Exceptions/Pipeline/InvalidCellTypeException.*
common/Exceptions/Pipeline/InvalidConversionException.*
common/Exceptions/Pipeline/InvalidDimensionsException.*
common/Exceptions/Pipeline/InvalidLimitsException.*
common/Exceptions/Pipeline/InvalidMergeException.*
common/Exceptions/Pipeline/InvalidSetException.*
common/Exceptions/Pipeline/LogicalIndexException.*
common/Exceptions/Pipeline/NoCurveException.*
common/Exceptions/Pipeline/NoDefaultVariableException.*
common/Exceptions/Pipeline/NoInputException.*
common/Exceptions/Pipeline/NonQueryableInputException.*
common/Exceptions/Pipeline/PipelineException.h
common/Exceptions/Pipeline/StubReferencedException.*
common/Exceptions/Pipeline/UnexpectedValueException.*
common/Exceptions/Pipeline/avtexception_exports.h
common/Exceptions/Plotter/InvalidColortableException.*
common/Exceptions/Plotter/LibraryNotFoundException.*
common/Exceptions/Plotter/PlotterException.h

common/expr/ExprGrammar.*
common/expr/ExprInit.C
common/expr/ExprNode.*
common/expr/ExprNodeFactory.h
common/expr/ExprParseTreeNode.*
common/expr/ExprParser.*
common/expr/ExprScanner.*
common/expr/ExprToken.h
common/expr/InvalidExpressionException.*
common/expr/ParsingExprList.*
common/expr/RecursiveExpressionException.*
common/expr/expr_exports.h

common/misc/ConfigureInfo.C.in
common/misc/ConfigureInfo.h
common/misc/DebugStream.h
common/misc/DebugStreamFull.*
common/misc/Environment.*
common/misc/FileFunctions.*
common/misc/InstallationFunctions.*
common/misc/StackTimer.*
common/misc/TimingsManager.*
common/misc/VisItException.*
common/misc/VisItInit.*
common/misc/legend_defines.h
common/misc/misc_exports.h

common/parser/Colors.h
common/parser/ConfiguratingItem.*
common/parser/ConfiguratingSet.*
common/parser/Dictionary.*
common/parser/Grammar.*
common/parser/ParseException.h
common/parser/ParseTreeNode.*
common/parser/Parser.C
common/parser/Pos.h
common/parser/Rule.*
common/parser/Scanner.*
common/parser/Sequence.*
common/parser/State.h
common/parser/Symbol.*
common/parser/SymbolSet.h
common/parser/Token.*
common/parser/VisItParser.h
common/parser/parser_exports.h

common/plugin/DatabasePluginInfo.*
common/plugin/DatabasePluginManager.*
common/plugin/InvalidDirectoryException.*
common/plugin/InvalidPluginException.*
common/plugin/OperatorPluginInfo.h
common/plugin/PluginBroadcaster.*
common/plugin/PluginManager.*
common/plugin/database_plugin_exports.h
common/plugin/operator_plugin_exports.h
common/plugin/plot_plugin_exports.h
common/plugin/plugin_entry_point.h
common/plugin/plugin_exports.h
common/plugin/plugin_vartypes.h

common/state/AttributeGroup.*
common/state/AttributeSubject.*
common/state/ColorAttribute.*
common/state/ColorControlPoint.*
common/state/ColorControlPointList.*
common/state/ColorTableAttributes.*
common/state/CompactSILRestrictionAttributes.*
common/state/ConfigManager.*
common/state/DBOptionsAttributes.*
common/state/DBPluginInfoAttributes.*
common/state/DataNode.*
common/state/DatabaseAttributes.*
common/state/Expression.*
common/state/ExpressionList.*
common/state/FileOpenOptions.*
common/state/GlobalAttributes.*
common/state/JSONNode.*
common/state/LightAttributes.*
common/state/LightList.*
common/state/Line.*
common/state/LineoutInfo.h
common/state/MapNode.*
common/state/NameschemeAttributes.*
common/state/NamespaceAttributes.*
common/state/Observer.*
common/state/PickAttributes.*
common/state/PickVarInfo.*
common/state/Plot.*
common/state/PlotInfoAttributes.*
common/state/RenderingAttributes.*
common/state/SILArrayAttributes.*
common/state/SILAttributes.*
common/state/SILMatrixAttributes.*
common/state/SILRestrictionAttributes.*
common/state/SelectionProperties.*
common/state/SimpleObserver.*
common/state/Subject.*
common/state/Variant.*
common/state/View2DAttributes.*
common/state/View3DAttributes.*
common/state/ViewAxisArrayAttributes.*
common/state/ViewCurveAttributes.*
common/state/WindowAttributes.*
common/state/XMLNode.*
common/state/state_exports.h

common/utility/AtomicProperties.*
common/utility/BJHash.h
common/utility/CoordUtils.C
common/utility/EqualVal.h
common/utility/FixedLengthBitField.h
common/utility/Interpolator.h
common/utility/MRUCache.h
common/utility/Namescheme.*
common/utility/StringHash.h
common/utility/StringHelpers.*
common/utility/Utility.*
common/utility/VisItAtomic.h
common/utility/VisItStreamUtil.h
common/utility/array_ref_ptr.h
common/utility/enumtypes.h
common/utility/maptypes.h
common/utility/ref_ptr.h
common/utility/snprintf.h
common/utility/utility_exports.h
common/utility/vectortypes.h
common/utility/visit_gzstream.*
common/utility/visitstream.h
common/utility/void_ref_ptr.*
common/utility/win32-regex.*

common/CMakeLists.txt

include/visit-cmake.h.in
include/visit-hdf5.h

visit_vtk/full/visit_vtk_exports.h
visit_vtk/full/vtkAccessors.h
visit_vtk/full/vtkBinaryPartitionVolumeFromVolume.*
visit_vtk/full/vtkCSGCell.*
visit_vtk/full/vtkCSGFixedLengthBitField.h
visit_vtk/full/vtkCSGGrid.*
visit_vtk/full/vtkMultiSplitter.*
visit_vtk/full/vtkPolyDataOnionPeelFilter.*
visit_vtk/full/vtkSurfaceFromVolume.*
visit_vtk/full/vtkUnstructuredGridRelevantPointsFilter.*
visit_vtk/full/vtkVisItCellDataToPointData.*
visit_vtk/full/vtkVisItClipper.*
visit_vtk/full/vtkVisItPolyDataNormals.*
visit_vtk/full/vtkVisItSplitter.*
visit_vtk/full/vtkVolumeFromCSGVolume.*
visit_vtk/full/vtkVolumeFromVolume.*
visit_vtk/full/CMakeLists.txt

visit_vtk/lightweight/ClipCases.h
visit_vtk/lightweight/ClipCases*.C
visit_vtk/lightweight/visit_vtk_light_exports.h
visit_vtk/lightweight/vtkCellIntersections.*
visit_vtk/lightweight/vtkDataSetFromVolume.*
visit_vtk/lightweight/vtkElementLabelArray.*
visit_vtk/lightweight/vtkEnumThreshold.*
visit_vtk/lightweight/vtkPolyDataRelevantPointsFilter.*
visit_vtk/lightweight/vtkTriangulationTables.*
visit_vtk/lightweight/vtkUnstructuredGridBoundaryFilter.*
visit_vtk/lightweight/vtkUnstructuredGridFacelistFilter.*
visit_vtk/lightweight/vtkVisItCellLocator.*
visit_vtk/lightweight/vtkVisItPointLocator.*
visit_vtk/lightweight/vtkVisItUtility.*
visit_vtk/lightweight/CMakeLists.txt

visit_vtk/CMakeLists.txt
"

extract_source () {
    git_archive
    pushd "$extractdir/$name-reduced"
    find . -name "*.code" -delete
    find . -name "*.xml" -delete
    mv CMakeLists.paraview.txt CMakeLists.txt
    popd
}

. "${BASH_SOURCE%/*}/update-common.sh"
