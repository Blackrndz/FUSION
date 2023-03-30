/* ****************************************************************************
 * $Revision: 78229 $:
 * $Author: pisan.jariyasettachok $:
 * $Date: 2022-04-07 14:37:05 +0700 (Thu, 07 Apr 2022) $:
 * $HeadURL: https://svn03.rapid4cloud.com/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Aging%20Methods%20-%20Aging%20Methods.sql $:
 * $Id: Manage Aging Methods - Aging Methods.sql 78229 2022-04-07 07:37:05Z pisan.jariyasettachok $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


select QRSLT.BUCKET_NAME RES_AGING_METHOD_NAME
	,QRSLT.AGING_TYPE_MEANING RES_AGING_TYPE
	,QRSLT.MEANING RES_ENABLED
	,QRSLT.SET_NAME RES_AGING_METHOD_SET
	,QRSLT.DESCRIPTION	 RES_AGING_METHOD_DESCRIPTION
  ,QRSLT.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
  ,QRSLT.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
  ,QRSLT.CREATED_BY  RSC_CREATED_BY
  ,QRSLT.CREATION_DATE  RSC_CREATION_DATE
  ,null RSC_LEDGER_ID
  ,null RSC_CHART_OF_ACCOUNTS_ID
  ,null RSC_BUSINESS_UNIT_ID
  ,null RSC_LEGAL_ENTITY_ID
  ,null RSC_ORGANIZATION_ID
  ,null RSC_BUSINESS_GROUP_ID
  ,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

from
	(SELECT	
	 AgingBucketsEO.LAST_UPDATED_BY
	, AgingBucketsEO.LAST_UPDATE_DATE
	, AgingBucketsEO.CREATED_BY
	, AgingBucketsEO.CREATION_DATE
	, AgingBucketsEO.BUCKET_NAME
	, ArLookupPEO.MEANING  AGING_TYPE_MEANING
	, AgingBucketsEO.DESCRIPTION
	,SetIdSetPEO.SET_NAME
	, CollLookupEO.MEANING
	from AR_AGING_BUCKETS AGINGBUCKETSEO
	,IEX_LOOKUPS_V COLLLOOKUPEO
	, AR_LOOKUPS ARLOOKUPPEO
	,FND_SETID_SETS_VL SetIdSetPEO
	WHERE((AgingBucketsEO.STATUS   = CollLookupEO.LOOKUP_CODE)
	AND(CollLookupEO.LOOKUP_TYPE   = 'IEX_AGING_TYPE')
	and(AGINGBUCKETSEO.AGING_TYPE != 'INTTIER'))
	and ARLOOKUPPEO.LOOKUP_CODE = AgingBucketsEO.AGING_TYPE
	and ARLOOKUPPEO.LOOKUP_TYPE        = 'AGING_BUCKETS_TYPE'
	and SETIDSETPEO.SET_ID = AGINGBUCKETSEO.SET_ID
	) QRSLT
ORDER BY BUCKET_NAME