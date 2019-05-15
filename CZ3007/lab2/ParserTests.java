package test;

import static org.junit.Assert.fail;

import java.io.StringReader;

import lexer.Lexer;

import org.junit.Test;

import parser.Parser;

public class ParserTests {
	private void runtest(String src) {
		runtest(src, true);
	}

	private void runtest(String src, boolean succeed) {
		Parser parser = new Parser();
		try {
			parser.parse(new Lexer(new StringReader(src)));
			if(!succeed) {
				fail("Test was supposed to fail, but succeeded");
			}
		} catch (beaver.Parser.Exception e) {
			if(succeed) {
				e.printStackTrace();
				fail(e.getMessage());
			}
		} catch (Throwable e) {
			e.printStackTrace();
			fail(e.getMessage());
		}
	}

	@Test
	public void testEmptyModule() {
		runtest("module Test { }");
	}
	@Test
	public void testModuleNameNoClash() {
		runtest("module M { }",
				"module N { }");
	}
	@Test
	public void testResolvedImport() {
		runtest("module M { import N; }",
				"module N { }");
	}
	
	@Test
	public void testFunctionNoNameClash() {
		runtest("module M {" +
				"  void foo() { }" +
				"  void bar() { }" +
				"}");
	}
	@Test
	public void test1() {
		runtest("module M {" +
				"import module1;" +
				"import module2;"+
				"}");
	}
	@Test
	public void test2() {
		runtest("module M {" +
				"public type float = \"FLOAT\";" +
				"type enum = \"ENUM\";"+
				"}");
	}
	@Test
	public void test3() {
		runtest("module M {" +
				"public void fun() {" +
				"a[5+7/3] = [2, 3, 4];"+
				"fun(4, 5, 6);"+
				"}"+
				"}");
	}
}
