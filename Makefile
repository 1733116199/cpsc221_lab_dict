EXE = lab_dict
EXE_FAC = fac
EXE_FIB = fib_generator

OBJS_DIR = .objs
OBJS_ANAGRAM_STUDENT = anagram_dict.o
OBJS_FIB_STUDENT = fib.o
OBJS_MAIN = main.o
OBJS_FIB_PROVIDED = fib_generator.o
OBJS_FAC_PROVIDED = fac.o
OBJS_HOMOPHONE_STUDENT = pronounce_dict.o cartalk_puzzle.o
OBJS_COMMON_WORDS_STUDENT = common_words.o

CXX = clang++
LD = clang++
WARNINGS = -pedantic -Wall -Werror -Wfatal-errors -Wextra -Wno-unused-parameter -Wno-unused-variable
CXXFLAGS = -std=c++1y -stdlib=libc++ -g -O0 $(WARNINGS) -MMD -MP -c
LDFLAGS = -std=c++1y -stdlib=libc++ -lc++abi -lpthread

all:$(EXE_FAC) \
	$(EXE_FIB) \
	$(EXE) \

data:
	svn export https://subversion.ews.illinois.edu/svn/sp17-cs225/_shared/lab_dict_data data

# Pattern rules for object files
$(OBJS_DIR)/%.o: %.cpp | $(OBJS_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

# Create directories
$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

# Rules for executables... we can use a pattern for the -asan versions, but, unfortunately, we can't use a pattern for the normal executables
$(EXE):
	$(LD) $^ $(LDFLAGS) -o $@
$(EXE_FAC):
	$(LD) $^ $(LDFLAGS) -o $@
$(EXE_FIB):
	$(LD) $^ $(LDFLAGS) -o $@

# Executable dependencies
$(EXE):               $(patsubst %.o, $(OBJS_DIR)/%.o,        $(OBJS_COMMON_WORDS_STUDENT)) \
							$(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_ANAGRAM_STUDENT)) \
							$(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_HOMOPHONE_STUDENT))  \
							$(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_FIB_STUDENT)) \
							$(patsubst %.o, $(OBJS_DIR)/%.o, $(OBJS_MAIN))
$(EXE_FAC):               $(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_FAC_STUDENT)) $(patsubst %.o, $(OBJS_DIR)/%.o, $(OBJS_FAC_PROVIDED))
$(EXE_FIB):               $(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_FIB_STUDENT)) $(patsubst %.o, $(OBJS_DIR)/%.o, $(OBJS_FIB_PROVIDED))

# Include automatically generated dependencies
-include $(OBJS_DIR)/*.d

clean:
	rm -rf $(EXE) \
		$(EXE_FIB) \
		$(EXE_FAC) \
		$(OBJS_DIR)

tidy: clean
	rm -rf doc

.PHONY: all tidy clean
