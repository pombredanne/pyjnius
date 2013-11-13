
cdef JNIEnv *default_env = NULL

cdef extern int gettid()
cdef JavaVM *jvm = NULL

cdef JNIEnv *get_jnienv():
    global default_env
    # first call, init.
    if default_env == NULL:
        default_env = get_platform_jnienv()
        default_env[0].GetJavaVM(default_env, &jvm)

    # return the current env attached to the thread
    # XXX it threads are created from C (not java), we'll leak here.
    cdef JNIEnv *env = NULL
    jvm[0].AttachCurrentThread(jvm, &env, NULL)
    return env

