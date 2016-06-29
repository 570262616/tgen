package langs

import (
	"log"

	"github.com/samuel/go-thrift/parser"
)

type BaseGen struct {
	Lang    string
	Thrifts map[string]*parser.Thrift
}

func (g *BaseGen) Init(lang string, parsedThrift map[string]*parser.Thrift) {
	g.Lang = lang
	g.Thrifts = parsedThrift
	g.CheckNamespace()
	g.CheckSameName()
}

func (g *BaseGen) CheckNamespace() {
	for f, t := range g.Thrifts {
		if _, ok := t.Namespaces[g.Lang]; !ok {
			log.Fatalf("Namespace not found for language '%s' in file '%s'", g.Lang, f)
		}
	}
}

func (g *BaseGen) CheckSameName() {
	for f, t := range g.Thrifts {
		for _, s := range t.Services {
			for _, st := range t.Structs {
				if s.Name != st.Name {
					continue
				}

				log.Fatalf("name of struct %q equals to service %q in file %q", st.Name, s.Name, f)
			}
		}
	}
}
