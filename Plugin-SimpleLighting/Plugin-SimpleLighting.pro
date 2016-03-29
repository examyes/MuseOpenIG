#-------------------------------------------------
#
# Project created by QtCreator 2015-02-17T22:54:05
#
#-------------------------------------------------

QT       -= core gui

#CONFIG += silent

TARGET = Plugin-SimpleLighting
TEMPLATE = lib

DEFINES += IGPLUGINSIMPLELIGHTING_LIBRARY OPENIG_SDK

SOURCES += igpluginsimplelighting.cpp

HEADERS +=

INCLUDEPATH += ../
DEPENDPATH += ../

LIBS += -losg -losgDB -losgViewer -lOpenThreads -losgShadow \
        -lOpenIG-Engine -lOpenIG-Base -lOpenIG-PluginBase

OTHER_FILES += libIgPlugin-SimpleLighting.so.xml

OTHER_FILES += CMakeLists.txt
DISTFILES += CMakeLists.txt

OTHER_FILES += \
    $${PWD}/DataFiles/* \
    $${PWD}/CmakeLists.txt

unix {
    !mac:contains(QMAKE_HOST.arch, x86_64):{
        DESTDIR = /usr/local/lib64/igplugins
        target.path = /usr/local/lib64/igplugins
    } else {
        DESTDIR = /usr/local/lib/igplugins
        target.path = /usr/local/lib/igplugins
    }
    message(Libs will be installed into $$DESTDIR)

    INSTALLS += target

    INCLUDEPATH += /usr/local/include
    DEPENDPATH += /usr/local/include
    INCLUDEPATH += /usr/local/lib64
    DEPENDPATH += /usr/local/lib64

    FILE = $${PWD}/DataFiles/libIgPlugin-SimpleLighting.so.xml
    DDIR = $${DESTDIR}/libIgPlugin-SimpleLighting.so.xml
    mac: DDIR = $${DESTDIR}/libIgPlugin-SimpleLighting.dylib.xml

    QMAKE_POST_LINK =  test -d $$quote($$DESTDIR) || $$QMAKE_MKDIR $$quote($$DESTDIR) $$escape_expand(\\n\\t)
    QMAKE_POST_LINK += test -e $$quote($$DDIR) || $$QMAKE_COPY $$quote($$FILE) $$quote($$DDIR) $$escape_expand(\\n\\t)

    # library version number files
    exists( "../openig_version.pri" ) {

	include( "../openig_version.pri" )
	isEmpty( VERSION ){ error( "bad or undefined VERSION variable inside file openig_version.pri" )
	} else {
	message( "Set version info to: $$VERSION" )
	}

    }
    else { error( "could not find pri library version file openig_version.pri" ) }

    # end of library version number files
}

win32-g++:QMAKE_CXXFLAGS += -fpermissive -shared-libgcc -D_GLIBCXX_DLL

win32 {
    OSGROOT = $$(OSG_ROOT)
    isEmpty(OSGROOT) {
        message(\"OpenSceneGraph\" not detected...)
    }
    else {
        message(\"OpenSceneGraph\" detected in \"$$OSGROOT\")
        INCLUDEPATH += $$OSGROOT/include
    }
    OSGBUILD = $$(OSG_BUILD)
    isEmpty(OSGBUILD) {
        message(\"OpenSceneGraph build\" not detected...)
    }
    else {
        message(\"OpenSceneGraph build\" detected in \"$$OSGBUILD\")
        DEPENDPATH += $$OSGBUILD/lib
        INCLUDEPATH += $$OSGBUILD/include
        LIBS += -L$$OSGBUILD/lib
    }

    OPENIGBUILD = $$(OPENIG_BUILD)
    isEmpty (OPENIGBUILD) {
        OPENIGBUILD = $$IN_PWD/..
    }
    DESTDIR = $$OPENIGBUILD/lib
    DLLDESTDIR = $$OPENIGBUILD/bin/igplugins

    LIBS += -L$$OPENIGBUILD/lib # -lstdc++.dll

    FILE = $${PWD}/DataFiles/libIgPlugin-SimpleLighting.so.xml
    DFILE = $${DLLDESTDIR}/IgPlugin-SimpleLighting.dll.xml

    FILE ~= s,/,\\,g
    DFILE ~= s,/,\\,g

    QMAKE_POST_LINK =  if not exist $$quote($$DLLDESTDIR) $$QMAKE_MKDIR $$quote($$DLLDESTDIR) $$escape_expand(\\n\\t)
    QMAKE_POST_LINK += if not exist $$quote($$DFILE) copy /y $$quote($$FILE) $$quote($$DFILE) $$escape_expand(\\n\\t)
}
