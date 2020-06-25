#determine the kernel release
execute_process(
    COMMAND uname -r
    OUTPUT_VARIABLE KERNEL_REL
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

set(KERNEL_HEADERS_DIR /lib/modules/${KERNEL_REL}/build)

if(KERNEL_HEADERS_DIR)
    set(KERNEL_HEADERS_INCLUDE_DIRS
        ${KERNEL_HEADERS_DIR}/include
        ${KERNEL_HEADERS_DIR}/arch/x86
        include CACHE PATH "Kernel headers include dirs"
    )
    mark_as_advanced(KERNEL_HEADERS_INCLUDE_DIRS)
endif()
