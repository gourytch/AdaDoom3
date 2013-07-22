--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
package Neo.File.Mesh.Model.Id.MD5
  is
  -------------
  -- Records --
  -------------
    type Record_Element
      is record
        
struct aiFace;

namespace Assimp     {
namespace MD5               {

// ---------------------------------------------------------------------------
/** Represents a single element in a MD5 file
 *  
 *  Elements are always contained in sections.
*/
struct Element
{
       //! Points to the starting point of the element
       //! Whitespace at the beginning and at the end have been removed,
       //! Elements are terminated with \0
       char* szStart;

       //! Original line number (can be used in error messages
       //! if a parsing error occurs)
       unsigned int iLineNumber;
};

typedef std::vector< Element > ElementList;

// ---------------------------------------------------------------------------
/** Represents a section of a MD5 file (such as the mesh or the joints section)
 *  
 *  A section is always enclosed in { and } brackets.
*/
struct Section
{
       //! Original line number (can be used in error messages
       //! if a parsing error occurs)
       unsigned int iLineNumber;

       //! List of all elements which have been parsed in this section.
       ElementList mElements;

       //! Name of the section
       std::string mName;

       //! For global elements: the value of the element as string
       //! Iif !length() the section is not a global element
       std::string mGlobalValue;
};

typedef std::vector< Section> SectionList;

// ---------------------------------------------------------------------------
/** Basic information about a joint
*/
struct BaseJointDescription
{
       //! Name of the bone
       aiString mName;

       //! Parent index of the bone
       int mParentIndex;
};

// ---------------------------------------------------------------------------
/** Represents a bone (joint) descriptor in a MD5Mesh file
*/
struct BoneDesc : BaseJointDescription
{
       //! Absolute position of the bone
       aiVector3D mPositionXYZ;

       //! Absolute rotation of the bone
       aiVector3D mRotationQuat;
       aiQuaternion mRotationQuatConverted;

       //! Absolute transformation of the bone
       //! (temporary)
       aiMatrix4x4 mTransform;

       //! Inverse transformation of the bone
       //! (temporary)
       aiMatrix4x4 mInvTransform;

       //! Internal
       unsigned int mMap;
};

typedef std::vector< BoneDesc > BoneList;

// ---------------------------------------------------------------------------
/** Represents a bone (joint) descriptor in a MD5Anim file
*/
struct AnimBoneDesc : BaseJointDescription
{
       //! Flags (AI_MD5_ANIMATION_FLAG_xxx)
       unsigned int iFlags;

       //! Index of the first key that corresponds to this anim bone
       unsigned int iFirstKeyIndex;
};

typedef std::vector< AnimBoneDesc > AnimBoneList;


// ---------------------------------------------------------------------------
/** Represents a base frame descriptor in a MD5Anim file
*/
struct BaseFrameDesc
{
       aiVector3D vPositionXYZ;
       aiVector3D vRotationQuat;
};

typedef std::vector< BaseFrameDesc > BaseFrameList;

// ---------------------------------------------------------------------------
/** Represents a camera animation frame in a MDCamera file
*/
struct CameraAnimFrameDesc : BaseFrameDesc
{
       float fFOV;
};

typedef std::vector< CameraAnimFrameDesc > CameraFrameList;

// ---------------------------------------------------------------------------
/** Represents a frame descriptor in a MD5Anim file
*/
struct FrameDesc
{
       //! Index of the frame
       unsigned int iIndex;

       //! Animation keyframes - a large blob of data at first
       std::vector< float > mValues;
};

typedef std::vector< FrameDesc > FrameList;

// ---------------------------------------------------------------------------
/** Represents a vertex  descriptor in a MD5 file
*/
struct VertexDesc
{
       VertexDesc()
              : mFirstWeight       (0)
              , mNumWeights (0)
       {}

       //! UV cordinate of the vertex
       aiVector2D mUV;

       //! Index of the first weight of the vertex in
       //! the vertex weight list
       unsigned int mFirstWeight;

       //! Number of weights assigned to this vertex
       unsigned int mNumWeights;
};

typedef std::vector< VertexDesc > VertexList;

// ---------------------------------------------------------------------------
/** Represents a vertex weight descriptor in a MD5 file
*/
struct WeightDesc
{
       //! Index of the bone to which this weight refers
       unsigned int mBone;

       //! The weight value
       float mWeight;

       //! The offset position of this weight
       // ! (in the coordinate system defined by the parent bone)
       aiVector3D vOffsetPosition;
};

typedef std::vector< WeightDesc > WeightList;
typedef std::vector< aiFace > FaceList;

// ---------------------------------------------------------------------------
/** Represents a mesh in a MD5 file
*/
struct MeshDesc
{
       //! Weights of the mesh
       WeightList mWeights;

       //! Vertices of the mesh
       VertexList mVertices;

       //! Faces of the mesh
       FaceList mFaces;

       //! Name of the shader (=texture) to be assigned to the mesh
       aiString mShader;
};

typedef std::vector< MeshDesc > MeshList;

// ---------------------------------------------------------------------------
// Convert a quaternion to its usual representation
inline void ConvertQuaternion (const aiVector3D& in, aiQuaternion& out) {

       out.x = in.x;
       out.y = in.y;
       out.z = in.z;

       const float t = 1.0f - (in.x*in.x) - (in.y*in.y) - (in.z*in.z);

       if (t < 0.0f)
              out.w = 0.0f;
       else out.w = sqrt (t);
}

// ---------------------------------------------------------------------------
/** Parses the data sections of a MD5 mesh file
*/
class MD5MeshParser
{
public:

       // -------------------------------------------------------------------
       /** Constructs a new MD5MeshParser instance from an existing
        *  preparsed list of file sections.
        *
        *  @param mSections List of file sections (output of MD5Parser)
        */
       MD5MeshParser(SectionList& mSections);

       //! List of all meshes
       MeshList mMeshes;

       //! List of all joints
       BoneList mJoints;
};

// remove this flag if you need to the bounding box data
#define AI_MD5_PARSE_NO_BOUNDS

// ---------------------------------------------------------------------------
/** Parses the data sections of a MD5 animation file
*/
class MD5AnimParser
{
public:

       // -------------------------------------------------------------------
       /** Constructs a new MD5AnimParser instance from an existing
        *  preparsed list of file sections.
        *
        *  @param mSections List of file sections (output of MD5Parser)
        */
       MD5AnimParser(SectionList& mSections);

       
       //! Output frame rate
       float fFrameRate;

       //! List of animation bones
       AnimBoneList mAnimatedBones;

       //! List of base frames
       BaseFrameList mBaseFrames;

       //! List of animation frames
       FrameList mFrames;

       //! Number of animated components
       unsigned int mNumAnimatedComponents;
};

// ---------------------------------------------------------------------------
/** Parses the data sections of a MD5 camera animation file
*/
class MD5CameraParser
{
public:

       // -------------------------------------------------------------------
       /** Constructs a new MD5CameraParser instance from an existing
        *  preparsed list of file sections.
        *
        *  @param mSections List of file sections (output of MD5Parser)
        */
       MD5CameraParser(SectionList& mSections);

       
       //! Output frame rate
       float fFrameRate;

       //! List of cuts
       std::vector<unsigned int> cuts;

       //! Frames
       CameraFrameList frames;
};

// ---------------------------------------------------------------------------
/** Parses the block structure of MD5MESH and MD5ANIM files (but does no
 *  further processing)
*/
class MD5Parser
{
public:

       // -------------------------------------------------------------------
       /** Constructs a new MD5Parser instance from an existing buffer.
        *
        *  @param buffer File buffer
        *  @param fileSize Length of the file in bytes (excluding a terminal 0)
        */
       MD5Parser(char* buffer, unsigned int fileSize);

       
       // -------------------------------------------------------------------
       /** Report a specific error message and throw an exception
        *  @param error Error message to be reported
        *  @param line Index of the line where the error occured
        */
       static void ReportError (const char* error, unsigned int line);

       // -------------------------------------------------------------------
       /** Report a specific warning
        *  @param warn Warn message to be reported
        *  @param line Index of the line where the error occured
        */
       static void ReportWarning (const char* warn, unsigned int line);


       void ReportError (const char* error) {
              return ReportError(error, lineNumber);
       }

       void ReportWarning (const char* warn) {
              return ReportWarning(warn, lineNumber);
       }

public:

       //! List of all sections which have been read
       SectionList mSections;

private:

       // -------------------------------------------------------------------
       /** Parses a file section. The current file pointer must be outside
        *  of a section.
        *  @param out Receives the section data
        *  @return true if the end of the file has been reached
        *  @throws ImportErrorException if an error occurs
        */
       bool ParseSection(Section& out);

       // -------------------------------------------------------------------
       /** Parses the file header
        *  @throws ImportErrorException if an error occurs
        */
       void ParseHeader();


       // override these functions to make sure the line counter gets incremented
       // -------------------------------------------------------------------
       bool SkipLine( const char* in, const char** out)
       {
              ++lineNumber;
              return Assimp::SkipLine(in,out);
       }
       // -------------------------------------------------------------------
       bool SkipLine( )
       {
              return SkipLine(buffer,(const char**)&buffer);
       }
       // -------------------------------------------------------------------
       bool SkipSpacesAndLineEnd( const char* in, const char** out)
       {
              bool bHad = false;
              bool running = true;
              while (running)      {
                     if( *in == '\r' || *in == '\n')    {
                             // we open files in binary mode, so there could be \r\n sequences ...
                            if (!bHad)    {
                                   bHad = true;
                                   ++lineNumber;
                            }
                     }
                     else if (*in == '\t' || *in == ' ')bHad = false;
                     else break;
                     in++;
              }
              *out = in;
              return *in != '\0';
       }
       // -------------------------------------------------------------------
       bool SkipSpacesAndLineEnd( )
       {
              return SkipSpacesAndLineEnd(buffer,(const char**)&buffer);
       }
       // -------------------------------------------------------------------
       bool SkipSpaces( )
       {
              return Assimp::SkipSpaces((const char**)&buffer);
       }

       char* buffer;
       unsigned int fileSize;
       unsigned int lineNumber;
};
}}
/*
Open Asset Import Library (assimp)
----------------------------------------------------------------------

Copyright (c) 2006-2012, assimp team
All rights reserved.

Redistribution and use of this software in source and binary forms, 
with or without modification, are permitted provided that the 
following conditions are met:

* Redistributions of source code must retain the above
  copyright notice, this list of conditions and the
  following disclaimer.

* Redistributions in binary form must reproduce the above
  copyright notice, this list of conditions and the
  following disclaimer in the documentation and/or other
  materials provided with the distribution.

* Neither the name of the assimp team, nor the names of its
  contributors may be used to endorse or promote products
  derived from this software without specific prior
  written permission of the assimp team.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

----------------------------------------------------------------------
*/


/** @file   MD5Loader.h
 *  @brief Definition of the .MD5 importer class.
 *  http://www.modwiki.net/wiki/MD5_(file_format)
*/
#ifndef AI_MD5LOADER_H_INCLUDED
#define AI_MD5LOADER_H_INCLUDED

#include "BaseImporter.h"
#include "MD5Parser.h"

#include "../include/assimp/types.h"

namespace Assimp  {

class IOStream;
using namespace Assimp::MD5;

// ---------------------------------------------------------------------------
/** Importer class for the MD5 file format
*/
class MD5Importer : public BaseImporter
{
public:
  MD5Importer();
  ~MD5Importer();


public:

  // -------------------------------------------------------------------
  /** Returns whether the class can handle the format of the given file. 
   * See BaseImporter::CanRead() for details.
   */
  bool CanRead( const std::string& pFile, IOSystem* pIOHandler,
    bool checkSig) const;

protected:

  // -------------------------------------------------------------------
  /** Return importer meta information.
   * See #BaseImporter::GetInfo for the details
   */
  const aiImporterDesc* GetInfo () const;

  // -------------------------------------------------------------------
  /** Called prior to ReadFile().
   * The function is a request to the importer to update its configuration
   * basing on the Importer's configuration property list.
   */
  void SetupProperties(const Importer* pImp);
  
  // -------------------------------------------------------------------
  /** Imports the given file into the given scene structure. 
   * See BaseImporter::InternReadFile() for details
   */
  void InternReadFile( const std::string& pFile, aiScene* pScene, 
    IOSystem* pIOHandler);

protected:


  // -------------------------------------------------------------------
  /** Load a *.MD5MESH file.
   */
  void LoadMD5MeshFile ();

  // -------------------------------------------------------------------
  /** Load a *.MD5ANIM file.
   */
  void LoadMD5AnimFile ();

  // -------------------------------------------------------------------
  /** Load a *.MD5CAMERA file.
   */
  void LoadMD5CameraFile ();

  // -------------------------------------------------------------------
  /** Construct node hierarchy from a given MD5ANIM 
   *  @param iParentID Current parent ID
   *  @param piParent Parent node to attach to
   *  @param bones Input bones
   *  @param node_anims Generated node animations
  */
  void AttachChilds_Anim(int iParentID,aiNode* piParent, 
    AnimBoneList& bones,const aiNodeAnim** node_anims);

  // -------------------------------------------------------------------
  /** Construct node hierarchy from a given MD5MESH 
   *  @param iParentID Current parent ID
   *  @param piParent Parent node to attach to
   *  @param bones Input bones
  */
  void AttachChilds_Mesh(int iParentID,aiNode* piParent,BoneList& bones);

  // -------------------------------------------------------------------
  /** Build unique vertex buffers from a given MD5ANIM
   *  @param meshSrc Input data
   */
  void MakeDataUnique (MD5::MeshDesc& meshSrc);

  // -------------------------------------------------------------------
  /** Load the contents of a specific file into memory and
   *  alocates a buffer to keep it.
   *
   *  mBuffer is modified to point to this buffer.
   *  @param pFile File stream to be read
  */
  void LoadFileIntoMemory (IOStream* pFile);
  void UnloadFileFromMemory ();


  /** IOSystem to be used to access files */
  IOSystem* mIOHandler;

  /** Path to the file, excluding the file extension but
      with the dot */
  std::string mFile;

  /** Buffer to hold the loaded file */
  char* mBuffer;

  /** Size of the file */
  unsigned int fileSize;

  /** Current line number. For debugging purposes */
  unsigned int iLineNumber;

  /** Scene to be filled */
  aiScene* pScene;

  /** (Custom) I/O handler implementation */
  IOSystem* pIOHandler;

  /** true if a MD5MESH file has already been parsed */
  bool bHadMD5Mesh;

  /** true if a MD5ANIM file has already been parsed */
  bool bHadMD5Anim;

  /** true if a MD5CAMERA file has already been parsed */
  bool bHadMD5Camera;

  /** configuration option: prevent anim autoload */
  bool configNoAutoLoad;
};

} // end of namespace Assimp
/*
---------------------------------------------------------------------------
Open Asset Import Library (assimp)
---------------------------------------------------------------------------

Copyright (c) 2006-2012, assimp team

All rights reserved.

Redistribution and use of this software in source and binary forms, 
with or without modification, are permitted provided that the following 
conditions are met:

* Redistributions of source code must retain the above
  copyright notice, this list of conditions and the
  following disclaimer.

* Redistributions in binary form must reproduce the above
  copyright notice, this list of conditions and the
  following disclaimer in the documentation and/or other
  materials provided with the distribution.

* Neither the name of the assimp team, nor the names of its
  contributors may be used to endorse or promote products
  derived from this software without specific prior
  written permission of the assimp team.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------
*/

/** @file  MD5Loader.cpp
 *  @brief Implementation of the MD5 importer class 
 */

#include "AssimpPCH.h"
#ifndef ASSIMP_BUILD_NO_MD5_IMPORTER

// internal headers
#include "RemoveComments.h"
#include "MD5Loader.h"
#include "StringComparison.h"
#include "fast_atof.h"
#include "SkeletonMeshBuilder.h"

using namespace Assimp;

// Minimum weight value. Weights inside [-n ... n] are ignored
#define AI_MD5_WEIGHT_EPSILON 1e-5f


static const aiImporterDesc desc = {
  "Doom 3 / MD5 Mesh Importer",
  "",
  "",
  "",
  aiImporterFlags_SupportBinaryFlavour,
  0,
  0,
  0,
  0,
  "md5mesh md5camera md5anim"
};

// ------------------------------------------------------------------------------------------------
// Constructor to be privately used by Importer
MD5Importer::MD5Importer()
: mBuffer()
, configNoAutoLoad (false)
{}

// ------------------------------------------------------------------------------------------------
// Destructor, private as well 
MD5Importer::~MD5Importer()
{}

// ------------------------------------------------------------------------------------------------
// Returns whether the class can handle the format of the given file. 
bool MD5Importer::CanRead( const std::string& pFile, IOSystem* pIOHandler, bool checkSig) const
{
  const std::string extension = GetExtension(pFile);

  if (extension == "md5anim" || extension == "md5mesh" || extension == "md5camera")
    return true;
  else if (!extension.length() || checkSig) {
    if (!pIOHandler) {
      return true;
    }
    const char* tokens[] = {"MD5Version"};
    return SearchFileHeaderForToken(pIOHandler,pFile,tokens,1);
  }
  return false;
}

// ------------------------------------------------------------------------------------------------
// Get list of all supported extensions
const aiImporterDesc* MD5Importer::GetInfo () const
{
  return &desc;
}

// ------------------------------------------------------------------------------------------------
// Setup import properties
void MD5Importer::SetupProperties(const Importer* pImp)
{
  // AI_CONFIG_IMPORT_MD5_NO_ANIM_AUTOLOAD
  configNoAutoLoad = (0 !=  pImp->GetPropertyInteger(AI_CONFIG_IMPORT_MD5_NO_ANIM_AUTOLOAD,0));
}

// ------------------------------------------------------------------------------------------------
// Imports the given file into the given scene structure. 
void MD5Importer::InternReadFile( const std::string& pFile, 
                 aiScene* _pScene, IOSystem* _pIOHandler)
{
  pIOHandler = _pIOHandler;
  pScene     = _pScene;
  bHadMD5Mesh = bHadMD5Anim = bHadMD5Camera = false;

  // remove the file extension
  const std::string::size_type pos = pFile.find_last_of('.');
  mFile = (std::string::npos == pos ? pFile : pFile.substr(0,pos+1));

  const std::string extension = GetExtension(pFile);
  try {
    if (extension == "md5camera") {
      LoadMD5CameraFile();
    }
    else if (configNoAutoLoad || extension == "md5anim") {
      // determine file extension and process just *one* file
      if (extension.length() == 0) {
        throw DeadlyImportError("Failure, need file extension to determine MD5 part type");
      }
      if (extension == "md5anim") {
        LoadMD5AnimFile();
      }
      else if (extension == "md5mesh") {
        LoadMD5MeshFile();
      }
    }
    else {
      LoadMD5MeshFile();
      LoadMD5AnimFile();
    }
  }
  catch ( ... ) { // std::exception, Assimp::DeadlyImportError
    UnloadFileFromMemory();
    throw;
  }

  // make sure we have at least one file
  if (!bHadMD5Mesh && !bHadMD5Anim && !bHadMD5Camera) {
    throw DeadlyImportError("Failed to read valid contents out of this MD5* file");
  }

  // Now rotate the whole scene 90 degrees around the x axis to match our internal coordinate system
  pScene->mRootNode->mTransformation = aiMatrix4x4(1.f,0.f,0.f,0.f,
    0.f,0.f,1.f,0.f,0.f,-1.f,0.f,0.f,0.f,0.f,0.f,1.f);

  // the output scene wouldn't pass the validation without this flag
  if (!bHadMD5Mesh) {
    pScene->mFlags |= AI_SCENE_FLAGS_INCOMPLETE;
  }

  // clean the instance -- the BaseImporter instance may be reused later.
  UnloadFileFromMemory();
}

// ------------------------------------------------------------------------------------------------
// Load a file into a memory buffer
void MD5Importer::LoadFileIntoMemory (IOStream* file)
{
  // unload the previous buffer, if any
  UnloadFileFromMemory();

  ai_assert(NULL != file);
  fileSize = (unsigned int)file->FileSize();
  ai_assert(fileSize);

  // allocate storage and copy the contents of the file to a memory buffer
  pScene = pScene;
  mBuffer = new char[fileSize+1];
  file->Read( (void*)mBuffer, 1, fileSize);
  iLineNumber = 1;

  // append a terminal 0
  mBuffer[fileSize] = '\0';

  // now remove all line comments from the file
  CommentRemover::RemoveLineComments("//",mBuffer,' ');
}

// ------------------------------------------------------------------------------------------------
// Unload the current memory buffer
void MD5Importer::UnloadFileFromMemory ()
{
  // delete the file buffer
  delete[] mBuffer;
  mBuffer = NULL;
  fileSize = 0;
}

// ------------------------------------------------------------------------------------------------
// Build unique vertices
void MD5Importer::MakeDataUnique (MD5::MeshDesc& meshSrc)
{
  std::vector<bool> abHad(meshSrc.mVertices.size(),false);

  // allocate enough storage to keep the output structures
  const unsigned int iNewNum = meshSrc.mFaces.size()*3;
  unsigned int iNewIndex = meshSrc.mVertices.size();
  meshSrc.mVertices.resize(iNewNum);

  // try to guess how much storage we'll need for new weights
  const float fWeightsPerVert = meshSrc.mWeights.size() / (float)iNewIndex;
  const unsigned int guess = (unsigned int)(fWeightsPerVert*iNewNum); 
  meshSrc.mWeights.reserve(guess + (guess >> 3)); // + 12.5% as buffer

  for (FaceList::const_iterator iter = meshSrc.mFaces.begin(),iterEnd = meshSrc.mFaces.end();iter != iterEnd;++iter){
    const aiFace& face = *iter;
    for (unsigned int i = 0; i < 3;++i) {
      if (face.mIndices[0] >= meshSrc.mVertices.size()) {
        throw DeadlyImportError("MD5MESH: Invalid vertex index");
      }

      if (abHad[face.mIndices[i]])  {
        // generate a new vertex
        meshSrc.mVertices[iNewIndex] = meshSrc.mVertices[face.mIndices[i]];
        face.mIndices[i] = iNewIndex++;
      }
      else abHad[face.mIndices[i]] = true;
    }
    // swap face order
    std::swap(face.mIndices[0],face.mIndices[2]);
  }
}

// ------------------------------------------------------------------------------------------------
// Recursive node graph construction from a MD5MESH
void MD5Importer::AttachChilds_Mesh(int iParentID,aiNode* piParent, BoneList& bones)
{
  ai_assert(NULL != piParent && !piParent->mNumChildren);

  // First find out how many children we'll have
  for (int i = 0; i < (int)bones.size();++i)  {
    if (iParentID != i && bones[i].mParentIndex == iParentID) {
      ++piParent->mNumChildren;
    }
  }
  if (piParent->mNumChildren) {
    piParent->mChildren = new aiNode*[piParent->mNumChildren];
    for (int i = 0; i < (int)bones.size();++i)  {
      // (avoid infinite recursion)
      if (iParentID != i && bones[i].mParentIndex == iParentID) {
        aiNode* pc;
        // setup a new node
        *piParent->mChildren++ = pc = new aiNode();
        pc->mName = aiString(bones[i].mName); 
        pc->mParent = piParent;

        // get the transformation matrix from rotation and translational components
        aiQuaternion quat; 
        MD5::ConvertQuaternion ( bones[i].mRotationQuat, quat );

        // FIX to get to Assimp's quaternion conventions
        quat.w *= -1.f;

        bones[i].mTransform = aiMatrix4x4 ( quat.GetMatrix());
        bones[i].mTransform.a4 = bones[i].mPositionXYZ.x;
        bones[i].mTransform.b4 = bones[i].mPositionXYZ.y;
        bones[i].mTransform.c4 = bones[i].mPositionXYZ.z;

        // store it for later use
        pc->mTransformation = bones[i].mInvTransform = bones[i].mTransform;
        bones[i].mInvTransform.Inverse();

        // the transformations for each bone are absolute, so we need to multiply them
        // with the inverse of the absolute matrix of the parent joint
        if (-1 != iParentID)  {
          pc->mTransformation = bones[iParentID].mInvTransform * pc->mTransformation;
        }

        // add children to this node, too
        AttachChilds_Mesh( i, pc, bones);
      }
    }
    // undo offset computations
    piParent->mChildren -= piParent->mNumChildren;
  }
}

// ------------------------------------------------------------------------------------------------
// Recursive node graph construction from a MD5ANIM
void MD5Importer::AttachChilds_Anim(int iParentID,aiNode* piParent, AnimBoneList& bones,const aiNodeAnim** node_anims)
{
  ai_assert(NULL != piParent && !piParent->mNumChildren);

  // First find out how many children we'll have
  for (int i = 0; i < (int)bones.size();++i)  {
    if (iParentID != i && bones[i].mParentIndex == iParentID) {
      ++piParent->mNumChildren;
    }
  }
  if (piParent->mNumChildren) {
    piParent->mChildren = new aiNode*[piParent->mNumChildren];
    for (int i = 0; i < (int)bones.size();++i)  {
      // (avoid infinite recursion)
      if (iParentID != i && bones[i].mParentIndex == iParentID)
      {
        aiNode* pc;
        // setup a new node
        *piParent->mChildren++ = pc = new aiNode();
        pc->mName = aiString(bones[i].mName); 
        pc->mParent = piParent;

        // get the corresponding animation channel and its first frame
        const aiNodeAnim** cur = node_anims;
        while ((**cur).mNodeName != pc->mName)++cur;

        aiMatrix4x4::Translation((**cur).mPositionKeys[0].mValue,pc->mTransformation);
        pc->mTransformation = pc->mTransformation * aiMatrix4x4((**cur).mRotationKeys[0].mValue.GetMatrix()) ;

        // add children to this node, too
        AttachChilds_Anim( i, pc, bones,node_anims);
      }
    }
    // undo offset computations
    piParent->mChildren -= piParent->mNumChildren;
  }
}

// ------------------------------------------------------------------------------------------------
// Load a MD5MESH file
void MD5Importer::LoadMD5MeshFile ()
{
  std::string pFile = mFile + "md5mesh";
  boost::scoped_ptr<IOStream> file( pIOHandler->Open( pFile, "rb"));

  // Check whether we can read from the file
  if( file.get() == NULL || !file->FileSize())  {
    DefaultLogger::get()->warn("Failed to access MD5MESH file: " + pFile);
    return;
  }
  bHadMD5Mesh = true;
  LoadFileIntoMemory(file.get());

  // now construct a parser and parse the file
  MD5::MD5Parser parser(mBuffer,fileSize);

  // load the mesh information from it
  MD5::MD5MeshParser meshParser(parser.mSections);

  // create the bone hierarchy - first the root node and dummy nodes for all meshes
  pScene->mRootNode = new aiNode("<MD5_Root>");
  pScene->mRootNode->mNumChildren = 2;
  pScene->mRootNode->mChildren = new aiNode*[2];

  // build the hierarchy from the MD5MESH file
  aiNode* pcNode = pScene->mRootNode->mChildren[1] = new aiNode();
  pcNode->mName.Set("<MD5_Hierarchy>");
  pcNode->mParent = pScene->mRootNode;
  AttachChilds_Mesh(-1,pcNode,meshParser.mJoints);

  pcNode = pScene->mRootNode->mChildren[0] = new aiNode();
  pcNode->mName.Set("<MD5_Mesh>");
  pcNode->mParent = pScene->mRootNode;

#if 0
  if (pScene->mRootNode->mChildren[1]->mNumChildren) /* start at the right hierarchy level */
    SkeletonMeshBuilder skeleton_maker(pScene,pScene->mRootNode->mChildren[1]->mChildren[0]);
#else

  // FIX: MD5 files exported from Blender can have empty meshes
  for (std::vector<MD5::MeshDesc>::const_iterator it  = meshParser.mMeshes.begin(),end = meshParser.mMeshes.end(); it != end;++it) {
    if (!(*it).mFaces.empty() && !(*it).mVertices.empty())
      ++pScene->mNumMaterials;
  }

  // generate all meshes
  pScene->mNumMeshes = pScene->mNumMaterials;
  pScene->mMeshes = new aiMesh*[pScene->mNumMeshes];
  pScene->mMaterials = new aiMaterial*[pScene->mNumMeshes];

  //  storage for node mesh indices
  pcNode->mNumMeshes = pScene->mNumMeshes;
  pcNode->mMeshes = new unsigned int[pcNode->mNumMeshes];
  for (unsigned int m = 0; m < pcNode->mNumMeshes;++m)
    pcNode->mMeshes[m] = m;

  unsigned int n = 0;
  for (std::vector<MD5::MeshDesc>::iterator it  = meshParser.mMeshes.begin(),end = meshParser.mMeshes.end(); it != end;++it) {
    MD5::MeshDesc& meshSrc = *it;
    if (meshSrc.mFaces.empty() || meshSrc.mVertices.empty())
      continue;

    aiMesh* mesh = pScene->mMeshes[n] = new aiMesh();
    mesh->mPrimitiveTypes = aiPrimitiveType_TRIANGLE;

    // generate unique vertices in our internal verbose format
    MakeDataUnique(meshSrc);

    mesh->mNumVertices = (unsigned int) meshSrc.mVertices.size();
    mesh->mVertices = new aiVector3D[mesh->mNumVertices];
    mesh->mTextureCoords[0] = new aiVector3D[mesh->mNumVertices];
    mesh->mNumUVComponents[0] = 2;

    // copy texture coordinates
    aiVector3D* pv = mesh->mTextureCoords[0];
    for (MD5::VertexList::const_iterator iter =  meshSrc.mVertices.begin();iter != meshSrc.mVertices.end();++iter,++pv) {
      pv->x = (*iter).mUV.x;
      pv->y = 1.0f-(*iter).mUV.y; // D3D to OpenGL
      pv->z = 0.0f;
    }

    // sort all bone weights - per bone
    unsigned int* piCount = new unsigned int[meshParser.mJoints.size()];
    ::memset(piCount,0,sizeof(unsigned int)*meshParser.mJoints.size());

    for (MD5::VertexList::const_iterator iter =  meshSrc.mVertices.begin();iter != meshSrc.mVertices.end();++iter,++pv) {
      for (unsigned int jub = (*iter).mFirstWeight, w = jub; w < jub + (*iter).mNumWeights;++w)
      {
        MD5::WeightDesc& desc = meshSrc.mWeights[w];
        /* FIX for some invalid exporters */
        if (!(desc.mWeight < AI_MD5_WEIGHT_EPSILON && desc.mWeight >= -AI_MD5_WEIGHT_EPSILON ))
          ++piCount[desc.mBone]; 
      }
    }

    // check how many we will need
    for (unsigned int p = 0; p < meshParser.mJoints.size();++p)
      if (piCount[p])mesh->mNumBones++;

    if (mesh->mNumBones) // just for safety
    {
      mesh->mBones = new aiBone*[mesh->mNumBones];
      for (unsigned int q = 0,h = 0; q < meshParser.mJoints.size();++q) 
      {
        if (!piCount[q])continue;
        aiBone* p = mesh->mBones[h] = new aiBone();
        p->mNumWeights = piCount[q];
        p->mWeights = new aiVertexWeight[p->mNumWeights];
        p->mName = aiString(meshParser.mJoints[q].mName);
        p->mOffsetMatrix = meshParser.mJoints[q].mInvTransform;

        // store the index for later use
        MD5::BoneDesc& boneSrc = meshParser.mJoints[q];
        boneSrc.mMap = h++;

        // compute w-component of quaternion
        MD5::ConvertQuaternion( boneSrc.mRotationQuat, boneSrc.mRotationQuatConverted );
      }
  
      //unsigned int g = 0;
      pv = mesh->mVertices;
      for (MD5::VertexList::const_iterator iter =  meshSrc.mVertices.begin();iter != meshSrc.mVertices.end();++iter,++pv) {
        // compute the final vertex position from all single weights
        *pv = aiVector3D();

        // there are models which have weights which don't sum to 1 ...
        float fSum = 0.0f;
        for (unsigned int jub = (*iter).mFirstWeight, w = jub; w < jub + (*iter).mNumWeights;++w)
          fSum += meshSrc.mWeights[w].mWeight;
        if (!fSum) {
          DefaultLogger::get()->error("MD5MESH: The sum of all vertex bone weights is 0");
          continue;
        }

        // process bone weights
        for (unsigned int jub = (*iter).mFirstWeight, w = jub; w < jub + (*iter).mNumWeights;++w) {
          if (w >= meshSrc.mWeights.size())
            throw DeadlyImportError("MD5MESH: Invalid weight index");

          MD5::WeightDesc& desc = meshSrc.mWeights[w];
          if ( desc.mWeight < AI_MD5_WEIGHT_EPSILON && desc.mWeight >= -AI_MD5_WEIGHT_EPSILON) {
            continue;
          }

          const float fNewWeight = desc.mWeight / fSum; 

          // transform the local position into worldspace
          MD5::BoneDesc& boneSrc = meshParser.mJoints[desc.mBone];
          const aiVector3D v = boneSrc.mRotationQuatConverted.Rotate (desc.vOffsetPosition);

          // use the original weight to compute the vertex position
          // (some MD5s seem to depend on the invalid weight values ...)
          *pv += ((boneSrc.mPositionXYZ+v)* desc.mWeight);
      
          aiBone* bone = mesh->mBones[boneSrc.mMap];
          *bone->mWeights++ = aiVertexWeight((unsigned int)(pv-mesh->mVertices),fNewWeight);
        }
      }

      // undo our nice offset tricks ...
      for (unsigned int p = 0; p < mesh->mNumBones;++p) {
        mesh->mBones[p]->mWeights -= mesh->mBones[p]->mNumWeights;
      }
    }

    delete[] piCount;

    // now setup all faces - we can directly copy the list
    // (however, take care that the aiFace destructor doesn't delete the mIndices array)
    mesh->mNumFaces = (unsigned int)meshSrc.mFaces.size();
    mesh->mFaces = new aiFace[mesh->mNumFaces];
    for (unsigned int c = 0; c < mesh->mNumFaces;++c) {
      mesh->mFaces[c].mNumIndices = 3;
      mesh->mFaces[c].mIndices = meshSrc.mFaces[c].mIndices;
      meshSrc.mFaces[c].mIndices = NULL;
    }

    // generate a material for the mesh
    aiMaterial* mat = new aiMaterial();
    pScene->mMaterials[n] = mat;

    // insert the typical doom3 textures:
    // nnn_local.tga  - normal map
    // nnn_h.tga      - height map
    // nnn_s.tga      - specular map
    // nnn_d.tga      - diffuse map
    if (meshSrc.mShader.length && !strchr(meshSrc.mShader.data,'.')) {
    
      aiString temp(meshSrc.mShader);
      temp.Append("_local.tga");
      mat->AddProperty(&temp,AI_MATKEY_TEXTURE_NORMALS(0));

      temp =  aiString(meshSrc.mShader);
      temp.Append("_s.tga");
      mat->AddProperty(&temp,AI_MATKEY_TEXTURE_SPECULAR(0));

      temp =  aiString(meshSrc.mShader);
      temp.Append("_d.tga");
      mat->AddProperty(&temp,AI_MATKEY_TEXTURE_DIFFUSE(0));

      temp =  aiString(meshSrc.mShader);
      temp.Append("_h.tga");
      mat->AddProperty(&temp,AI_MATKEY_TEXTURE_HEIGHT(0));

      // set this also as material name
      mat->AddProperty(&meshSrc.mShader,AI_MATKEY_NAME);
    }
    else mat->AddProperty(&meshSrc.mShader,AI_MATKEY_TEXTURE_DIFFUSE(0));
    mesh->mMaterialIndex = n++;
  }
#endif
}

// ------------------------------------------------------------------------------------------------
// Load an MD5ANIM file
void MD5Importer::LoadMD5AnimFile ()
{
  std::string pFile = mFile + "md5anim";
  boost::scoped_ptr<IOStream> file( pIOHandler->Open( pFile, "rb"));

  // Check whether we can read from the file
  if( !file.get() || !file->FileSize()) {
    DefaultLogger::get()->warn("Failed to read MD5ANIM file: " + pFile);
    return;
  }
  LoadFileIntoMemory(file.get());

  // parse the basic file structure
  MD5::MD5Parser parser(mBuffer,fileSize);

  // load the animation information from the parse tree
  MD5::MD5AnimParser animParser(parser.mSections);

  // generate and fill the output animation
  if (animParser.mAnimatedBones.empty() || animParser.mFrames.empty() || 
    animParser.mBaseFrames.size() != animParser.mAnimatedBones.size())  {
    
    DefaultLogger::get()->error("MD5ANIM: No frames or animated bones loaded");
  }
  else {
    bHadMD5Anim = true;

    pScene->mAnimations = new aiAnimation*[pScene->mNumAnimations = 1];
    aiAnimation* anim = pScene->mAnimations[0] = new aiAnimation();
    anim->mNumChannels = (unsigned int)animParser.mAnimatedBones.size();
    anim->mChannels = new aiNodeAnim*[anim->mNumChannels];
    for (unsigned int i = 0; i < anim->mNumChannels;++i)  {
      aiNodeAnim* node = anim->mChannels[i] = new aiNodeAnim();
      node->mNodeName = aiString( animParser.mAnimatedBones[i].mName );

      // allocate storage for the keyframes
      node->mPositionKeys = new aiVectorKey[animParser.mFrames.size()];
      node->mRotationKeys = new aiQuatKey[animParser.mFrames.size()];
    }

    // 1 tick == 1 frame
    anim->mTicksPerSecond = animParser.fFrameRate;

    for (FrameList::const_iterator iter = animParser.mFrames.begin(), iterEnd = animParser.mFrames.end();iter != iterEnd;++iter){
      double dTime = (double)(*iter).iIndex;
      aiNodeAnim** pcAnimNode = anim->mChannels;
      if (!(*iter).mValues.empty() || iter == animParser.mFrames.begin()) /* be sure we have at least one frame */
      {
        // now process all values in there ... read all joints
        MD5::BaseFrameDesc* pcBaseFrame = &animParser.mBaseFrames[0];
        for (AnimBoneList::const_iterator iter2 = animParser.mAnimatedBones.begin(); iter2 != animParser.mAnimatedBones.end();++iter2,
          ++pcAnimNode,++pcBaseFrame)
        {
          if((*iter2).iFirstKeyIndex >= (*iter).mValues.size()) {

            // Allow for empty frames
            if ((*iter2).iFlags != 0) {
              throw DeadlyImportError("MD5: Keyframe index is out of range");
            
            }
            continue;
          }
          const float* fpCur = &(*iter).mValues[(*iter2).iFirstKeyIndex];
          aiNodeAnim* pcCurAnimBone = *pcAnimNode;

          aiVectorKey* vKey = &pcCurAnimBone->mPositionKeys[pcCurAnimBone->mNumPositionKeys++];
          aiQuatKey* qKey = &pcCurAnimBone->mRotationKeys  [pcCurAnimBone->mNumRotationKeys++];
          aiVector3D vTemp;

          // translational component
          for (unsigned int i = 0; i < 3; ++i) {
            if ((*iter2).iFlags & (1u << i)) {
              vKey->mValue[i] =  *fpCur++;
            }
            else vKey->mValue[i] = pcBaseFrame->vPositionXYZ[i];
          }

          // orientation component
          for (unsigned int i = 0; i < 3; ++i) {
            if ((*iter2).iFlags & (8u << i)) {
              vTemp[i] =  *fpCur++;
            }
            else vTemp[i] = pcBaseFrame->vRotationQuat[i];
          }

          MD5::ConvertQuaternion(vTemp, qKey->mValue);
          qKey->mTime = vKey->mTime = dTime;

          // we need this to get to Assimp quaternion conventions
          qKey->mValue.w *= -1.f;
        }
      }

      // compute the duration of the animation
      anim->mDuration = std::max(dTime,anim->mDuration);
    }

    // If we didn't build the hierarchy yet (== we didn't load a MD5MESH),
    // construct it now from the data given in the MD5ANIM.
    if (!pScene->mRootNode) {
      pScene->mRootNode = new aiNode();
      pScene->mRootNode->mName.Set("<MD5_Hierarchy>");

      AttachChilds_Anim(-1,pScene->mRootNode,animParser.mAnimatedBones,(const aiNodeAnim**)anim->mChannels);

      // Call SkeletonMeshBuilder to construct a mesh to represent the shape
      if (pScene->mRootNode->mNumChildren) {
        SkeletonMeshBuilder skeleton_maker(pScene,pScene->mRootNode->mChildren[0]);
      }
    }
  }
}

// ------------------------------------------------------------------------------------------------
// Load an MD5CAMERA file
void MD5Importer::LoadMD5CameraFile ()
{
  std::string pFile = mFile + "md5camera";
  boost::scoped_ptr<IOStream> file( pIOHandler->Open( pFile, "rb"));

  // Check whether we can read from the file
  if( !file.get() || !file->FileSize()) {
    throw DeadlyImportError("Failed to read MD5CAMERA file: " + pFile);
  }
  bHadMD5Camera = true;
  LoadFileIntoMemory(file.get());

  // parse the basic file structure
  MD5::MD5Parser parser(mBuffer,fileSize);

  // load the camera animation data from the parse tree
  MD5::MD5CameraParser cameraParser(parser.mSections);

  if (cameraParser.frames.empty()) {
    throw DeadlyImportError("MD5CAMERA: No frames parsed");
  }

  std::vector<unsigned int>& cuts = cameraParser.cuts;
  std::vector<MD5::CameraAnimFrameDesc>& frames = cameraParser.frames;

  // Construct output graph - a simple root with a dummy child.
  // The root node performs the coordinate system conversion
  aiNode* root = pScene->mRootNode = new aiNode("<MD5CameraRoot>");
  root->mChildren = new aiNode*[root->mNumChildren = 1];
  root->mChildren[0] = new aiNode("<MD5Camera>");
  root->mChildren[0]->mParent = root;

  // ... but with one camera assigned to it
  pScene->mCameras = new aiCamera*[pScene->mNumCameras = 1];
  aiCamera* cam = pScene->mCameras[0] = new aiCamera();
  cam->mName = "<MD5Camera>";

  // FIXME: Fov is currently set to the first frame's value
  cam->mHorizontalFOV = AI_DEG_TO_RAD( frames.front().fFOV );

  // every cut is written to a separate aiAnimation
  if (!cuts.size()) {
    cuts.push_back(0);
    cuts.push_back(frames.size()-1);
  }
  else {    
    cuts.insert(cuts.begin(),0);

    if (cuts.back() < frames.size()-1)
      cuts.push_back(frames.size()-1);
  }

  pScene->mNumAnimations = cuts.size()-1;
  aiAnimation** tmp = pScene->mAnimations = new aiAnimation*[pScene->mNumAnimations];
  for (std::vector<unsigned int>::const_iterator it = cuts.begin(); it != cuts.end()-1; ++it) {
  
    aiAnimation* anim = *tmp++ = new aiAnimation();
    anim->mName.length = ::sprintf(anim->mName.data,"anim%u_from_%u_to_%u",(unsigned int)(it-cuts.begin()),(*it),*(it+1));
    
    anim->mTicksPerSecond = cameraParser.fFrameRate;
    anim->mChannels = new aiNodeAnim*[anim->mNumChannels = 1];
    aiNodeAnim* nd  = anim->mChannels[0] = new aiNodeAnim();
    nd->mNodeName.Set("<MD5Camera>");

    nd->mNumPositionKeys = nd->mNumRotationKeys = *(it+1) - (*it);
    nd->mPositionKeys = new aiVectorKey[nd->mNumPositionKeys];
    nd->mRotationKeys = new aiQuatKey  [nd->mNumRotationKeys];
    for (unsigned int i = 0; i < nd->mNumPositionKeys; ++i) {

      nd->mPositionKeys[i].mValue = frames[*it+i].vPositionXYZ;
      MD5::ConvertQuaternion(frames[*it+i].vRotationQuat,nd->mRotationKeys[i].mValue);
      nd->mRotationKeys[i].mTime = nd->mPositionKeys[i].mTime = *it+i;
    }
  }
}
/*
---------------------------------------------------------------------------
Open Asset Import Library (assimp)
---------------------------------------------------------------------------

Copyright (c) 2006-2012, assimp team

All rights reserved.

Redistribution and use of this software in source and binary forms, 
with or without modification, are permitted provided that the following 
conditions are met:

* Redistributions of source code must retain the above
  copyright notice, this list of conditions and the
  following disclaimer.

* Redistributions in binary form must reproduce the above
  copyright notice, this list of conditions and the
  following disclaimer in the documentation and/or other
  materials provided with the distribution.

* Neither the name of the assimp team, nor the names of its
  contributors may be used to endorse or promote products
  derived from this software without specific prior
  written permission of the assimp team.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
---------------------------------------------------------------------------
*/

/** @file  MD5Parser.cpp 
 *  @brief Implementation of the MD5 parser class
 */
#include "AssimpPCH.h"

// internal headers
#include "MD5Loader.h"
#include "MaterialSystem.h"
#include "fast_atof.h"
#include "ParsingUtils.h"
#include "StringComparison.h"

using namespace Assimp;
using namespace Assimp::MD5;

// ------------------------------------------------------------------------------------------------
// Parse the segment structure fo a MD5 file
MD5Parser::MD5Parser(char* _buffer, unsigned int _fileSize )
{
  ai_assert(NULL != _buffer && 0 != _fileSize);

  buffer = _buffer;
  fileSize = _fileSize;
  lineNumber = 0;

  DefaultLogger::get()->debug("MD5Parser begin");

  // parse the file header
  ParseHeader();

  // and read all sections until we're finished
  bool running = true;
  while (running) {
    mSections.push_back(Section());
    Section& sec = mSections.back();
    if(!ParseSection(sec))  {
      break;
    }
  }

  if ( !DefaultLogger::isNullLogger())  {
    char szBuffer[128]; // should be sufficiently large
    ::sprintf(szBuffer,"MD5Parser end. Parsed %i sections",(int)mSections.size());
    DefaultLogger::get()->debug(szBuffer);
  }
}

// ------------------------------------------------------------------------------------------------
// Report error to the log stream
/*static*/ void MD5Parser::ReportError (const char* error, unsigned int line)
{
  char szBuffer[1024];
  ::sprintf(szBuffer,"[MD5] Line %i: %s",line,error);
  throw DeadlyImportError(szBuffer);
}

// ------------------------------------------------------------------------------------------------
// Report warning to the log stream
/*static*/ void MD5Parser::ReportWarning (const char* warn, unsigned int line)
{
  char szBuffer[1024]; 
  ::sprintf(szBuffer,"[MD5] Line %i: %s",line,warn);
  DefaultLogger::get()->warn(szBuffer);
}

// ------------------------------------------------------------------------------------------------
// Parse and validate the MD5 header
void MD5Parser::ParseHeader()
{
  // parse and validate the file version
  SkipSpaces();
  if (!TokenMatch(buffer,"MD5Version",10))  {
    ReportError("Invalid MD5 file: MD5Version tag has not been found");
  }
  SkipSpaces();
  unsigned int iVer = ::strtoul10(buffer,(const char**)&buffer);
  if (10 != iVer) {
    ReportError("MD5 version tag is unknown (10 is expected)");
  }
  SkipLine();

  // print the command line options to the console
  // FIX: can break the log length limit, so we need to be careful
  char* sz = buffer;
  while (!IsLineEnd( *buffer++));
  DefaultLogger::get()->info(std::string(sz,std::min((uintptr_t)MAX_LOG_MESSAGE_LENGTH, (uintptr_t)(buffer-sz))));
  SkipSpacesAndLineEnd();
}

// ------------------------------------------------------------------------------------------------
// Recursive MD5 parsing function
bool MD5Parser::ParseSection(Section& out)
{
  // store the current line number for use in error messages
  out.iLineNumber = lineNumber;

  // first parse the name of the section
  char* sz = buffer;
  while (!IsSpaceOrNewLine( *buffer))buffer++;
  out.mName = std::string(sz,(uintptr_t)(buffer-sz));
  SkipSpaces();

  bool running = true;
  while (running) {
    if ('{' == *buffer) {
      // it is a normal section so read all lines
      buffer++;
      bool run = true;
      while (run)
      {
        if (!SkipSpacesAndLineEnd()) {
          return false; // seems this was the last section
        }
        if ('}' == *buffer) {
          buffer++;
          break;
        }

        out.mElements.push_back(Element());
        Element& elem = out.mElements.back();

        elem.iLineNumber = lineNumber;
        elem.szStart = buffer;

        // terminate the line with zero 
        while (!IsLineEnd( *buffer))buffer++;
        if (*buffer) {
          ++lineNumber;
          *buffer++ = '\0';
        }
      }
      break;
    }
    else if (!IsSpaceOrNewLine(*buffer))  {
      // it is an element at global scope. Parse its value and go on
      sz = buffer;
      while (!IsSpaceOrNewLine( *buffer++));
      out.mGlobalValue = std::string(sz,(uintptr_t)(buffer-sz));
      continue;
    }
    break;
  }
  return SkipSpacesAndLineEnd();
}

// ------------------------------------------------------------------------------------------------
// Some dirty macros just because they're so funny and easy to debug

// skip all spaces ... handle EOL correctly
#define AI_MD5_SKIP_SPACES()  if(!SkipSpaces(&sz)) \
  MD5Parser::ReportWarning("Unexpected end of line",(*eit).iLineNumber);

  // read a triple float in brackets: (1.0 1.0 1.0)
#define AI_MD5_READ_TRIPLE(vec) \
  AI_MD5_SKIP_SPACES(); \
  if ('(' != *sz++) \
    MD5Parser::ReportWarning("Unexpected token: ( was expected",(*eit).iLineNumber); \
  AI_MD5_SKIP_SPACES(); \
  sz = fast_atoreal_move<float>(sz,(float&)vec.x); \
  AI_MD5_SKIP_SPACES(); \
  sz = fast_atoreal_move<float>(sz,(float&)vec.y); \
  AI_MD5_SKIP_SPACES(); \
  sz = fast_atoreal_move<float>(sz,(float&)vec.z); \
  AI_MD5_SKIP_SPACES(); \
  if (')' != *sz++) \
    MD5Parser::ReportWarning("Unexpected token: ) was expected",(*eit).iLineNumber);

  // parse a string, enclosed in quotation marks or not
#define AI_MD5_PARSE_STRING(out) \
  bool bQuota = (*sz == '\"'); \
  const char* szStart = sz; \
  while (!IsSpaceOrNewLine(*sz))++sz; \
  const char* szEnd = sz; \
  if (bQuota) { \
    szStart++; \
    if ('\"' != *(szEnd-=1)) { \
      MD5Parser::ReportWarning("Expected closing quotation marks in string", \
        (*eit).iLineNumber); \
      continue; \
    } \
  } \
  out.length = (size_t)(szEnd - szStart); \
  ::memcpy(out.data,szStart,out.length); \
  out.data[out.length] = '\0';

// ------------------------------------------------------------------------------------------------
// .MD5MESH parsing function
MD5MeshParser::MD5MeshParser(SectionList& mSections)
{
  DefaultLogger::get()->debug("MD5MeshParser begin");

  // now parse all sections
  for (SectionList::const_iterator iter =  mSections.begin(), iterEnd = mSections.end();iter != iterEnd;++iter){
    if ( (*iter).mName == "numMeshes")  {
      mMeshes.reserve(::strtoul10((*iter).mGlobalValue.c_str()));
    }
    else if ( (*iter).mName == "numJoints") {
      mJoints.reserve(::strtoul10((*iter).mGlobalValue.c_str()));
    }
    else if ((*iter).mName == "joints") {
      // "origin" -1 ( -0.000000 0.016430 -0.006044 ) ( 0.707107 0.000000 0.707107 )
      for (ElementList::const_iterator eit = (*iter).mElements.begin(), eitEnd = (*iter).mElements.end();eit != eitEnd; ++eit){
        mJoints.push_back(BoneDesc());
        BoneDesc& desc = mJoints.back();

        const char* sz = (*eit).szStart;
        AI_MD5_PARSE_STRING(desc.mName);
        AI_MD5_SKIP_SPACES();

        // negative values, at least -1, is allowed here
        desc.mParentIndex = (int)strtol10(sz,&sz);
    
        AI_MD5_READ_TRIPLE(desc.mPositionXYZ);
        AI_MD5_READ_TRIPLE(desc.mRotationQuat); // normalized quaternion, so w is not there
      }
    }
    else if ((*iter).mName == "mesh") {
      mMeshes.push_back(MeshDesc());
      MeshDesc& desc = mMeshes.back();

      for (ElementList::const_iterator eit = (*iter).mElements.begin(), eitEnd = (*iter).mElements.end();eit != eitEnd; ++eit){
        const char* sz = (*eit).szStart;

        // shader attribute
        if (TokenMatch(sz,"shader",6))  {
          AI_MD5_SKIP_SPACES();
          AI_MD5_PARSE_STRING(desc.mShader);
        }
        // numverts attribute
        else if (TokenMatch(sz,"numverts",8)) {
          AI_MD5_SKIP_SPACES();
          desc.mVertices.resize(strtoul10(sz));
        }
        // numtris attribute
        else if (TokenMatch(sz,"numtris",7))  {
          AI_MD5_SKIP_SPACES();
          desc.mFaces.resize(strtoul10(sz));
        }
        // numweights attribute
        else if (TokenMatch(sz,"numweights",10))  {
          AI_MD5_SKIP_SPACES();
          desc.mWeights.resize(strtoul10(sz));
        }
        // vert attribute
        // "vert 0 ( 0.394531 0.513672 ) 0 1"
        else if (TokenMatch(sz,"vert",4)) {
          AI_MD5_SKIP_SPACES();
          const unsigned int idx = ::strtoul10(sz,&sz);
          AI_MD5_SKIP_SPACES();
          if (idx >= desc.mVertices.size())
            desc.mVertices.resize(idx+1);

          VertexDesc& vert = desc.mVertices[idx]; 
          if ('(' != *sz++)
            MD5Parser::ReportWarning("Unexpected token: ( was expected",(*eit).iLineNumber);
          AI_MD5_SKIP_SPACES();
          sz = fast_atoreal_move<float>(sz,(float&)vert.mUV.x);
          AI_MD5_SKIP_SPACES();
          sz = fast_atoreal_move<float>(sz,(float&)vert.mUV.y);
          AI_MD5_SKIP_SPACES();
          if (')' != *sz++)
            MD5Parser::ReportWarning("Unexpected token: ) was expected",(*eit).iLineNumber);
          AI_MD5_SKIP_SPACES();
          vert.mFirstWeight = ::strtoul10(sz,&sz);
          AI_MD5_SKIP_SPACES();
          vert.mNumWeights = ::strtoul10(sz,&sz);
        }
        // tri attribute
        // "tri 0 15 13 12"
        else if (TokenMatch(sz,"tri",3)) {
          AI_MD5_SKIP_SPACES();
          const unsigned int idx = strtoul10(sz,&sz);
          if (idx >= desc.mFaces.size())
            desc.mFaces.resize(idx+1);

          aiFace& face = desc.mFaces[idx];  
          face.mIndices = new unsigned int[face.mNumIndices = 3];
          for (unsigned int i = 0; i < 3;++i) {
            AI_MD5_SKIP_SPACES();
            face.mIndices[i] = strtoul10(sz,&sz);
          }
        }
        // weight attribute
        // "weight 362 5 0.500000 ( -3.553583 11.893474 9.719339 )"
        else if (TokenMatch(sz,"weight",6)) {
          AI_MD5_SKIP_SPACES();
          const unsigned int idx = strtoul10(sz,&sz);
          AI_MD5_SKIP_SPACES();
          if (idx >= desc.mWeights.size())
            desc.mWeights.resize(idx+1);

          WeightDesc& weight = desc.mWeights[idx];  
          weight.mBone = strtoul10(sz,&sz);
          AI_MD5_SKIP_SPACES();
          sz = fast_atoreal_move<float>(sz,weight.mWeight);
          AI_MD5_READ_TRIPLE(weight.vOffsetPosition);
        }
      }
    }
  }
  DefaultLogger::get()->debug("MD5MeshParser end");
}

// ------------------------------------------------------------------------------------------------
// .MD5ANIM parsing function
MD5AnimParser::MD5AnimParser(SectionList& mSections)
{
  DefaultLogger::get()->debug("MD5AnimParser begin");

  fFrameRate = 24.0f;
  mNumAnimatedComponents = UINT_MAX;
  for (SectionList::const_iterator iter =  mSections.begin(), iterEnd = mSections.end();iter != iterEnd;++iter) {
    if ((*iter).mName == "hierarchy") {
      // "sheath" 0 63 6 
      for (ElementList::const_iterator eit = (*iter).mElements.begin(), eitEnd = (*iter).mElements.end();eit != eitEnd; ++eit) {
        mAnimatedBones.push_back ( AnimBoneDesc () );
        AnimBoneDesc& desc = mAnimatedBones.back();

        const char* sz = (*eit).szStart;
        AI_MD5_PARSE_STRING(desc.mName);
        AI_MD5_SKIP_SPACES();

        // parent index - negative values are allowed (at least -1)
        desc.mParentIndex = ::strtol10(sz,&sz);

        // flags (highest is 2^6-1)
        AI_MD5_SKIP_SPACES();
        if(63 < (desc.iFlags = ::strtoul10(sz,&sz))){
          MD5Parser::ReportWarning("Invalid flag combination in hierarchy section",(*eit).iLineNumber);
        }
        AI_MD5_SKIP_SPACES();

        // index of the first animation keyframe component for this joint
        desc.iFirstKeyIndex = ::strtoul10(sz,&sz);
      }
    }
    else if((*iter).mName == "baseframe") {
      // ( -0.000000 0.016430 -0.006044 ) ( 0.707107 0.000242 0.707107 )
      for (ElementList::const_iterator eit = (*iter).mElements.begin(), eitEnd = (*iter).mElements.end(); eit != eitEnd; ++eit) {
        const char* sz = (*eit).szStart;

        mBaseFrames.push_back ( BaseFrameDesc () );
        BaseFrameDesc& desc = mBaseFrames.back();

        AI_MD5_READ_TRIPLE(desc.vPositionXYZ);
        AI_MD5_READ_TRIPLE(desc.vRotationQuat);
      }
    }
    else if((*iter).mName ==  "frame")  {
      if (!(*iter).mGlobalValue.length()) {
        MD5Parser::ReportWarning("A frame section must have a frame index",(*iter).iLineNumber);
        continue;
      }

      mFrames.push_back ( FrameDesc () );
      FrameDesc& desc = mFrames.back();
      desc.iIndex = strtoul10((*iter).mGlobalValue.c_str());

      // we do already know how much storage we will presumably need
      if (UINT_MAX != mNumAnimatedComponents) {
        desc.mValues.reserve(mNumAnimatedComponents);
      }

      // now read all elements (continous list of floats)
      for (ElementList::const_iterator eit = (*iter).mElements.begin(), eitEnd = (*iter).mElements.end(); eit != eitEnd; ++eit){
        const char* sz = (*eit).szStart;
        while (SkipSpacesAndLineEnd(&sz)) {
          float f;sz = fast_atoreal_move<float>(sz,f);
          desc.mValues.push_back(f);
        }
      }
    }
    else if((*iter).mName == "numFrames") {
      mFrames.reserve(strtoul10((*iter).mGlobalValue.c_str()));
    }
    else if((*iter).mName == "numJoints") {
      const unsigned int num = strtoul10((*iter).mGlobalValue.c_str());
      mAnimatedBones.reserve(num);

      // try to guess the number of animated components if that element is not given
      if (UINT_MAX  == mNumAnimatedComponents) {
        mNumAnimatedComponents = num * 6;
      }
    }
    else if((*iter).mName == "numAnimatedComponents") {
      mAnimatedBones.reserve( strtoul10((*iter).mGlobalValue.c_str()));
    }
    else if((*iter).mName == "frameRate") {
      fast_atoreal_move<float>((*iter).mGlobalValue.c_str(),fFrameRate);
    }
  }
  DefaultLogger::get()->debug("MD5AnimParser end");
}

// ------------------------------------------------------------------------------------------------
// .MD5CAMERA parsing function
MD5CameraParser::MD5CameraParser(SectionList& mSections)
{
  DefaultLogger::get()->debug("MD5CameraParser begin");
  fFrameRate = 24.0f;

  for (SectionList::const_iterator iter =  mSections.begin(), iterEnd = mSections.end();iter != iterEnd;++iter) {
    if ((*iter).mName == "numFrames") {
      frames.reserve(strtoul10((*iter).mGlobalValue.c_str()));
    }
    else if ((*iter).mName == "frameRate")  {
      fFrameRate = fast_atof ((*iter).mGlobalValue.c_str());
    }
    else if ((*iter).mName == "numCuts")  {
      cuts.reserve(strtoul10((*iter).mGlobalValue.c_str()));
    }
    else if ((*iter).mName == "cuts") {
      for (ElementList::const_iterator eit = (*iter).mElements.begin(), eitEnd = (*iter).mElements.end(); eit != eitEnd; ++eit){
        cuts.push_back(strtoul10((*eit).szStart)+1);
      }
    }
    else if ((*iter).mName == "camera") {
      for (ElementList::const_iterator eit = (*iter).mElements.begin(), eitEnd = (*iter).mElements.end(); eit != eitEnd; ++eit){
        const char* sz = (*eit).szStart;

        frames.push_back(CameraAnimFrameDesc());
        CameraAnimFrameDesc& cur = frames.back();
        AI_MD5_READ_TRIPLE(cur.vPositionXYZ);
        AI_MD5_READ_TRIPLE(cur.vRotationQuat);
        AI_MD5_SKIP_SPACES();
        cur.fFOV = fast_atof(sz);
      }
    }
  }
  DefaultLogger::get()->debug("MD5CameraParser end");
}