declare var process: NodeProcess;
declare class NodeProcess extends EventEmitter {
  stdout: WritableStream;
}
declare class WritableStream extends EventEmitter {
  write(str: string, encoding?: string, fd?: string): boolean;
}
declare class EventEmitter {
}
process.stdout.write("こんにちは、世界！\n");
