#  The Makefile to build client lib and it's test

TARGETSDK =  /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk

CXX = xcrun -sdk $(TARGETSDK) g++

#  System Header
SYSTEM_HEADER_FLAGS = -I/opt/local/include -I/usr/include -I/usr/include/c++/4.2.1

#  System Root
SYSTEM_ROOT_FLAGS = -arch i386 -isysroot $(TARGETSDK)

#  The root dir
ROOT_DIR = /Users/tsgsz/github/OwbClientLib

FRAMEWORK_PATH_FLAGS = -F /System/Library/Frameworks


#  The 3rdParty dir
3RDPARTY_DIR = $(ROOT_DIR)/Thridparty

#  The gtest dir
GTEST_DIR = $(3RDPARTY_DIR)/gtest

#  The gmock dir
GMOCK_DIR = $(3RDPARTY_DIR)/gmock

#  The glog dir
GLOG_DIR = $(3RDPARTY_DIR)/glog

#  The gflags dir
GFLAGS_DIR = $(3RDPARTY_DIR)/gflags

#  The protobuf dir
PROTOBUF_DIR = $(3RDPARTY_DIR)/protobuf

#  The rcf dir
RCF_DIR = $(3RDPARTY_DIR)/RCF-2.0.0.2679

#  3rdparty include dir
# -I$(GLOG_DIR)/include -I$(GFLAGS_DIR)/include  
3RDPARTY_INCLUDE_FLAGS = -I$(PROTOBUF_DIR)/include -I$(RCF_DIR)/include

#  3rdparty lib dir
#3RDPARTY_LIB_FLAGS = -L$(GLOG_DIR)/lib -L$(GFLAGS_DIR)/lib  \
					 -L$(PROTOBUF_DIR)/lib 

#  3rdparty test include lib

TEST_FLAGS = -I$(GTEST_DIR)/include -I$(GMOCK_DIR)/include -L$(GTEST_DIR)/lib \
			 -L$(GMOCK_DIR)/lib -I$(GLOG_DIR)/include -I$(GFLAGS_DIR)/include \
             -L$(GLOG_DIR)/lib -L$(GFLAGS_DIR)/lib

#  Flags passed to preprocessor
CPPFLAGS += $(SYSTEM_ROOT_FLAGS)
CPPFLAGS += $(SYSTEM_HEADER_FLAGS) $(3RDPARTY_INCLUDE_FLAGS) $(3RDPARTY_LIB_FLAGS)

#  Flags passed to objective-c compiler
OBJFLAGS += $(FRAMEWORK_PATH_FLAGS) -framework Foundation -framework CoreGraphics 

#  Flags passed to the C++ compiler
CXXFLAGS += -g -Wall -Wextra

#  Output dir
OUTPUT_DIR = $(ROOT_DIR)/output

#  Static Client Library
LIB = libOwbClient.a

export

#  Obj
OBJ = $(ROOT_DIR)/NetWork/*.o $(ROOT_DIR)/Models/*.o $(ROOT_DIR)/View/*.o \
	  $(ROOT_DIR)/Tools/*.o $(ROOT_DIR)/Protobuffer/*.o

.PHONY : all
all:CHECK_OUTPUT_DIR $(LIB)
	$(AR) $(ARFLAGS) $(OUTPUT_DIR)/$(LIB) $(OBJ)

.PHONY : test
test:
	cd NetWork && $(MAKE) test
	cd Models && $(MAKE) test
	cd Tools && $(MAKE) test

.PHONY : clean
clean:
	rm -rf $(OUTPUT_DIR)
	$(MAKE) clean -C NetWork
	$(MAKE) clean -C Models
	$(MAKE) clean -C View
	$(MAKE) clean -C Tools
	$(MAKE) clean -C Protobuffer


CHECK_OUTPUT_DIR:
	mkdir -p $(OUTPUT_DIR)

$(LIB) : $(OBJ)

$(OBJ) : 
	$(MAKE) -C NetWork
	$(MAKE) -C Models
	$(MAKE) -C View
	$(MAKE) -C Tools
	$(MAKE) -C Protobuffer
