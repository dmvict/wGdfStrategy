( function _Utf8_test_s_()
{
'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../../wtools/Tools.s' );
  require( '../gdf/entry/Gdf.s' );
  _.include( 'wTesting' );
}

let _global = _global_;
let _ = _global_.wTools;

_.assert( _testerGlobal_.wTools !== _global_.wTools );

// --
// test
// --


function utf8( test )
{
  let context = this;

  var src = 'Lorem Ipsum is simply dummy text.';
  var buffer = _.bufferBytesFrom( src );

  test.case = 'buffer.bytes <-> string.utf8';

  var serialize = _.gdf.selectContext({ inFormat : 'buffer.bytes', outFormat : 'string.utf8' });
  test.identical( serialize.length, 1 );
  let utf8FromBuffer = serialize[ 0 ];

  var serialize = _.gdf.selectContext({ outFormat : 'buffer.bytes', inFormat : 'string.utf8' });
  test.identical( serialize.length, 1 );
  let utf8ToBuffer = serialize[ 0 ];

  var converted = utf8FromBuffer.encode({ data : buffer }).out;
  test.identical( converted.format, 'string.utf8' );
  test.is( _.strIs( converted.data ) );

  var converted = utf8ToBuffer.encode({ data : converted.data }).out;
  test.identical( converted.format, 'buffer.bytes' );
  test.is( _.bufferBytesIs( converted.data ) );
  test.identical( converted.data, buffer );
}

// --
// declare
// --

let Self =
{

  name : 'Tools.utf8.gdf',
  silencing : 1,

  context :
  {
  },

  tests :
  {
    utf8
  },

};

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
