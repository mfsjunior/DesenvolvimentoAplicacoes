$acadProtoDir = "microservicos\ms-academico\src\main\proto"
New-Item -Path $acadProtoDir -ItemType Directory -Force | Out-Null
$protoFile = @"
syntax = "proto3";
package academico;

option java_package = "com.unitech.grpc";
option java_multiple_files = true;

service AlunoService {
  rpc ConsultarAluno (AlunoRequest) returns (AlunoResponse);
}

message AlunoRequest {
  int64 id = 1;
}

message AlunoResponse {
  int64 id = 1;
  string nome = 2;
  double mensalidade = 3;
}
"@
Set-Content -Path "$acadProtoDir\aluno.proto" -Value $protoFile -Encoding UTF8

$grpcPlugin = @"
    <build>
        <extensions>
            <extension>
                <groupId>kr.motd.maven</groupId>
                <artifactId>os-maven-plugin</artifactId>
                <version>1.7.1</version>
            </extension>
        </extensions>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
            <plugin>
                <groupId>org.xolstice.maven.plugins</groupId>
                <artifactId>protobuf-maven-plugin</artifactId>
                <version>0.6.1</version>
                <configuration>
                    <protocArtifact>com.google.protobuf:protoc:3.21.12:exe:`${os.detected.classifier}</protocArtifact>
                    <pluginId>grpc-java</pluginId>
                    <pluginArtifact>io.grpc:protoc-gen-grpc-java:1.53.0:exe:`${os.detected.classifier}</pluginArtifact>
                </configuration>
                <executions>
                    <execution>
                        <goals>
                            <goal>compile</goal>
                            <goal>compile-custom</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
"@

$acadPom = "microservicos\ms-academico\pom.xml"
$acadContent = Get-Content $acadPom -Raw
$acadContent = $acadContent -replace "</project>", $grpcPlugin
Set-Content -Path $acadPom -Value $acadContent -Encoding UTF8

$finProtoDir = "microservicos\ms-financeiro\src\main\proto"
New-Item -Path $finProtoDir -ItemType Directory -Force | Out-Null
Set-Content -Path "$finProtoDir\aluno.proto" -Value $protoFile -Encoding UTF8

$finPom = "microservicos\ms-financeiro\pom.xml"
$finContent = Get-Content $finPom -Raw
$finContent = $finContent -replace "</project>", $grpcPlugin
Set-Content -Path $finPom -Value $finContent -Encoding UTF8

Write-Host "gRPC configs and protobuf plugins injected."
