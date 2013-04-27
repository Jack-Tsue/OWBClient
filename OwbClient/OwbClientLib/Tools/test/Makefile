
CPPFLAGS += $(TEST_FLAGS)

TEST_SRCS_ = OperationQueueTest.mm

DEPEND_LIBS_FLAGS = -lpthread -lglog -lgflags -lprotobuf -lgtest -lgmock 

test.out: $(OBJ) $(TEST_SRCS_) 
	$(CXX) $(CPPFLAGS) $(OBJFLAGS) $(CXXFLAGS) $(DEPEND_LIBS_FLAGS) $^ -o $@

.PHONY : clean
clean :
	rm -rf test.out
