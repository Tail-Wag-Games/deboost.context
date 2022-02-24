package fcontext

when ODIN_OS == .Windows {
    when ODIN_DEBUG == true {
        foreign import fcontext_lib "fcontextd.lib"
    }
    else {
        foreign import fcontext_lib "fcontext.lib"
    }
} else when ODIN_OS == .Darwin {
    foreign import fcontext_lib "fcontext.a"
}

import "core:c"

c_size_t :: c.size_t

FContext :: rawptr

FContext_Transfer :: struct {
    ctx: FContext,
    data: rawptr,
}

FContext_Stack :: struct {
    sptr: rawptr,
    ssize: c_size_t,
}

FContext_Callback :: proc "c" (transfer: FContext_Transfer)

@(default_calling_convention="c")
foreign fcontext_lib {
    /**
     * Switches to another context
     * @param to Target context to switch to
     * @param vp Custom user pointer to pass to new context
     */
    jump_fcontext :: proc(to: FContext, vp: rawptr) -> FContext_Transfer ---
    /**
     * Make a new context
     * @param sp Pointer to allocated stack memory
     * @param size Stack memory size
     * @param corofn Callback function for context (coroutine)
     */
    make_fcontext :: proc(sp: rawptr, size: c_size_t, corofn: FContext_Callback) -> FContext ---

    ontop_fcontext :: proc(to: FContext, vp: rawptr, fn: proc "c" (FContext_Transfer) -> FContext_Transfer) -> FContext_Transfer ---

    create_fcontext_stack :: proc(size: c_size_t) -> FContext_Stack ---
    destroy_fcontext_stack :: proc(s: ^FContext_Stack) ---
}