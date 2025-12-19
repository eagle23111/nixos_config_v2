self: super: {
  llama-cpp = super.llama-cpp.override {
    cudaSupport = true;
  };
}
