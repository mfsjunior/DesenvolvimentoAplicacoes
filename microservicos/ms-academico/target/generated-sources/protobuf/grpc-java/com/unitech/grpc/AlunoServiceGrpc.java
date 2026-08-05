package com.unitech.grpc;

import static io.grpc.MethodDescriptor.generateFullMethodName;

/**
 */
@javax.annotation.Generated(
    value = "by gRPC proto compiler (version 1.53.0)",
    comments = "Source: aluno.proto")
@io.grpc.stub.annotations.GrpcGenerated
public final class AlunoServiceGrpc {

  private AlunoServiceGrpc() {}

  public static final String SERVICE_NAME = "academico.AlunoService";

  // Static method descriptors that strictly reflect the proto.
  private static volatile io.grpc.MethodDescriptor<com.unitech.grpc.AlunoRequest,
      com.unitech.grpc.AlunoResponse> getConsultarAlunoMethod;

  @io.grpc.stub.annotations.RpcMethod(
      fullMethodName = SERVICE_NAME + '/' + "ConsultarAluno",
      requestType = com.unitech.grpc.AlunoRequest.class,
      responseType = com.unitech.grpc.AlunoResponse.class,
      methodType = io.grpc.MethodDescriptor.MethodType.UNARY)
  public static io.grpc.MethodDescriptor<com.unitech.grpc.AlunoRequest,
      com.unitech.grpc.AlunoResponse> getConsultarAlunoMethod() {
    io.grpc.MethodDescriptor<com.unitech.grpc.AlunoRequest, com.unitech.grpc.AlunoResponse> getConsultarAlunoMethod;
    if ((getConsultarAlunoMethod = AlunoServiceGrpc.getConsultarAlunoMethod) == null) {
      synchronized (AlunoServiceGrpc.class) {
        if ((getConsultarAlunoMethod = AlunoServiceGrpc.getConsultarAlunoMethod) == null) {
          AlunoServiceGrpc.getConsultarAlunoMethod = getConsultarAlunoMethod =
              io.grpc.MethodDescriptor.<com.unitech.grpc.AlunoRequest, com.unitech.grpc.AlunoResponse>newBuilder()
              .setType(io.grpc.MethodDescriptor.MethodType.UNARY)
              .setFullMethodName(generateFullMethodName(SERVICE_NAME, "ConsultarAluno"))
              .setSampledToLocalTracing(true)
              .setRequestMarshaller(io.grpc.protobuf.ProtoUtils.marshaller(
                  com.unitech.grpc.AlunoRequest.getDefaultInstance()))
              .setResponseMarshaller(io.grpc.protobuf.ProtoUtils.marshaller(
                  com.unitech.grpc.AlunoResponse.getDefaultInstance()))
              .setSchemaDescriptor(new AlunoServiceMethodDescriptorSupplier("ConsultarAluno"))
              .build();
        }
      }
    }
    return getConsultarAlunoMethod;
  }

  /**
   * Creates a new async stub that supports all call types for the service
   */
  public static AlunoServiceStub newStub(io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<AlunoServiceStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<AlunoServiceStub>() {
        @java.lang.Override
        public AlunoServiceStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new AlunoServiceStub(channel, callOptions);
        }
      };
    return AlunoServiceStub.newStub(factory, channel);
  }

  /**
   * Creates a new blocking-style stub that supports unary and streaming output calls on the service
   */
  public static AlunoServiceBlockingStub newBlockingStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<AlunoServiceBlockingStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<AlunoServiceBlockingStub>() {
        @java.lang.Override
        public AlunoServiceBlockingStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new AlunoServiceBlockingStub(channel, callOptions);
        }
      };
    return AlunoServiceBlockingStub.newStub(factory, channel);
  }

  /**
   * Creates a new ListenableFuture-style stub that supports unary calls on the service
   */
  public static AlunoServiceFutureStub newFutureStub(
      io.grpc.Channel channel) {
    io.grpc.stub.AbstractStub.StubFactory<AlunoServiceFutureStub> factory =
      new io.grpc.stub.AbstractStub.StubFactory<AlunoServiceFutureStub>() {
        @java.lang.Override
        public AlunoServiceFutureStub newStub(io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
          return new AlunoServiceFutureStub(channel, callOptions);
        }
      };
    return AlunoServiceFutureStub.newStub(factory, channel);
  }

  /**
   */
  public static abstract class AlunoServiceImplBase implements io.grpc.BindableService {

    /**
     */
    public void consultarAluno(com.unitech.grpc.AlunoRequest request,
        io.grpc.stub.StreamObserver<com.unitech.grpc.AlunoResponse> responseObserver) {
      io.grpc.stub.ServerCalls.asyncUnimplementedUnaryCall(getConsultarAlunoMethod(), responseObserver);
    }

    @java.lang.Override public final io.grpc.ServerServiceDefinition bindService() {
      return io.grpc.ServerServiceDefinition.builder(getServiceDescriptor())
          .addMethod(
            getConsultarAlunoMethod(),
            io.grpc.stub.ServerCalls.asyncUnaryCall(
              new MethodHandlers<
                com.unitech.grpc.AlunoRequest,
                com.unitech.grpc.AlunoResponse>(
                  this, METHODID_CONSULTAR_ALUNO)))
          .build();
    }
  }

  /**
   */
  public static final class AlunoServiceStub extends io.grpc.stub.AbstractAsyncStub<AlunoServiceStub> {
    private AlunoServiceStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected AlunoServiceStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new AlunoServiceStub(channel, callOptions);
    }

    /**
     */
    public void consultarAluno(com.unitech.grpc.AlunoRequest request,
        io.grpc.stub.StreamObserver<com.unitech.grpc.AlunoResponse> responseObserver) {
      io.grpc.stub.ClientCalls.asyncUnaryCall(
          getChannel().newCall(getConsultarAlunoMethod(), getCallOptions()), request, responseObserver);
    }
  }

  /**
   */
  public static final class AlunoServiceBlockingStub extends io.grpc.stub.AbstractBlockingStub<AlunoServiceBlockingStub> {
    private AlunoServiceBlockingStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected AlunoServiceBlockingStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new AlunoServiceBlockingStub(channel, callOptions);
    }

    /**
     */
    public com.unitech.grpc.AlunoResponse consultarAluno(com.unitech.grpc.AlunoRequest request) {
      return io.grpc.stub.ClientCalls.blockingUnaryCall(
          getChannel(), getConsultarAlunoMethod(), getCallOptions(), request);
    }
  }

  /**
   */
  public static final class AlunoServiceFutureStub extends io.grpc.stub.AbstractFutureStub<AlunoServiceFutureStub> {
    private AlunoServiceFutureStub(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected AlunoServiceFutureStub build(
        io.grpc.Channel channel, io.grpc.CallOptions callOptions) {
      return new AlunoServiceFutureStub(channel, callOptions);
    }

    /**
     */
    public com.google.common.util.concurrent.ListenableFuture<com.unitech.grpc.AlunoResponse> consultarAluno(
        com.unitech.grpc.AlunoRequest request) {
      return io.grpc.stub.ClientCalls.futureUnaryCall(
          getChannel().newCall(getConsultarAlunoMethod(), getCallOptions()), request);
    }
  }

  private static final int METHODID_CONSULTAR_ALUNO = 0;

  private static final class MethodHandlers<Req, Resp> implements
      io.grpc.stub.ServerCalls.UnaryMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.ServerStreamingMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.ClientStreamingMethod<Req, Resp>,
      io.grpc.stub.ServerCalls.BidiStreamingMethod<Req, Resp> {
    private final AlunoServiceImplBase serviceImpl;
    private final int methodId;

    MethodHandlers(AlunoServiceImplBase serviceImpl, int methodId) {
      this.serviceImpl = serviceImpl;
      this.methodId = methodId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("unchecked")
    public void invoke(Req request, io.grpc.stub.StreamObserver<Resp> responseObserver) {
      switch (methodId) {
        case METHODID_CONSULTAR_ALUNO:
          serviceImpl.consultarAluno((com.unitech.grpc.AlunoRequest) request,
              (io.grpc.stub.StreamObserver<com.unitech.grpc.AlunoResponse>) responseObserver);
          break;
        default:
          throw new AssertionError();
      }
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("unchecked")
    public io.grpc.stub.StreamObserver<Req> invoke(
        io.grpc.stub.StreamObserver<Resp> responseObserver) {
      switch (methodId) {
        default:
          throw new AssertionError();
      }
    }
  }

  private static abstract class AlunoServiceBaseDescriptorSupplier
      implements io.grpc.protobuf.ProtoFileDescriptorSupplier, io.grpc.protobuf.ProtoServiceDescriptorSupplier {
    AlunoServiceBaseDescriptorSupplier() {}

    @java.lang.Override
    public com.google.protobuf.Descriptors.FileDescriptor getFileDescriptor() {
      return com.unitech.grpc.Aluno.getDescriptor();
    }

    @java.lang.Override
    public com.google.protobuf.Descriptors.ServiceDescriptor getServiceDescriptor() {
      return getFileDescriptor().findServiceByName("AlunoService");
    }
  }

  private static final class AlunoServiceFileDescriptorSupplier
      extends AlunoServiceBaseDescriptorSupplier {
    AlunoServiceFileDescriptorSupplier() {}
  }

  private static final class AlunoServiceMethodDescriptorSupplier
      extends AlunoServiceBaseDescriptorSupplier
      implements io.grpc.protobuf.ProtoMethodDescriptorSupplier {
    private final String methodName;

    AlunoServiceMethodDescriptorSupplier(String methodName) {
      this.methodName = methodName;
    }

    @java.lang.Override
    public com.google.protobuf.Descriptors.MethodDescriptor getMethodDescriptor() {
      return getServiceDescriptor().findMethodByName(methodName);
    }
  }

  private static volatile io.grpc.ServiceDescriptor serviceDescriptor;

  public static io.grpc.ServiceDescriptor getServiceDescriptor() {
    io.grpc.ServiceDescriptor result = serviceDescriptor;
    if (result == null) {
      synchronized (AlunoServiceGrpc.class) {
        result = serviceDescriptor;
        if (result == null) {
          serviceDescriptor = result = io.grpc.ServiceDescriptor.newBuilder(SERVICE_NAME)
              .setSchemaDescriptor(new AlunoServiceFileDescriptorSupplier())
              .addMethod(getConsultarAlunoMethod())
              .build();
        }
      }
    }
    return result;
  }
}
