#  The Makefile to build ServerDelgate and it's test

#CXX = g++

#  System Header
SYSTEM_HEADER_DIR = /opt/local/include

#  The root dir
ROOT_DIR = ..

#  The 3rdparty dir
THRIDPARTY_DIR = $(ROOT_DIR)/Thridparty

#  To find the gtest
GTEST_DIR = $(THRIDPARTY_DIR)/gtest

#  To find the gmock
GMOCK_DIR = $(THRIDPARTY_DIR)/gmock

#  To find the Rcf
RCF_DIR = $(THRIDPARTY_DIR)/RCF-2.0.0.2679

#  Flags passed to the preprocessor
CPPFLAGS += -I$(GTEST_DIR)/include -I$(GMOCK_DIR)/include -I$(RCF_DIR)/include \
            -I$(SYSTEM_HEADER_DIR) -L$(GTEST_DIR)/lib -L$(GMOCK_DIR)/lib

#  Flags passed to the C++ compiler
CXXFLAGS += -g -Wall -Wextra

#  Test
TESTS = test/ServerDelegateTest.test

#  lib
LIBS = libServerDelegate.a

#  ServerDelegate sources
SERVER_DELEGATE_SRCS_ = internal/*.cc *.cc
SERVER_DELEGATE_TEST_SRCS_ = test/*.cc $(SERVER_DELEGATE_SRCS_)
#  All Google Mock headers

.PHONY : all
all : $(LIBS)

.PHONY : test
test : $(TESTS)

.PHONY : clean
clean :
	rm -rf $(TESTS) *.a *.o test/*.o 


libServerDelegate.a : ServerDelegate.o RCF.o
	$(AR) $(ARFLAGS) $@ $^

ServerDelegate.o RCF.o : $(SERVER_DELEGATE_SRCS_) $(RCF_DIR)/src/RCF/RCF.cpp
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c *.cc $(RCF_DIR)/src/RCF/RCF.cpp

$(TESTS) : $(SERVER_DELEGATE_TEST_SRCS_)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -lpthread -lgtest -lglog -lgflags \
	-lprotobuf $(SERVER_DELEGATE_TEST_SRCS_) $(RCF_DIR)/src/RCF/RCF.cpp -o $@
