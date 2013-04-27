

#  Proto srcs
PROTO_SRCS_ = *.cc
PROTOBUFFER_SRCS = $(PROTOBUF_DIR)/src/google/*.cc \
				   $(PROTOBUF_DIR)/src/google/io/*.cc \
				   $(PROTOBUF_DIR)/src/google/compiler/*.cc \
				   $(PROTOBUF_DIR)/src/google/testing/*.cc

#  libs
PROTO_OBJS = message.pb.o protobuf.o

export

.PHONY : all
all : $(PROTO_OBJS)

.PHONY : clean
clean :
	rm -rf $(PROTO_OBJS) 

$(PROTO_OBJS) : $(PROTO_SRCS_)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $(PROTO_SRCS_)
