/* ****************************************************************************
* $Revision: 55345 $:
* $Author: wuttipong.thongvises $:
* $Date: 2016-05-23 12:42:33 +0700 (Mon, 23 May 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/
FINANCIALS/Manage%20Server%20Configurations%20-%20Manage%20Data%20Quality%20Server%20Configurations.sql $:
* $Id: Manage Server Configurations - Manage Data Quality Server Configurations.sql 55345 2016-05-23 05:42:33Z
wuttipong.thongvises $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT benELIGYEO.NAME RES_NAME
,benELIGLOSEO.ORDR_NUM RES_SEQUENCE
,(SELECT NAME 
	FROM BEN_LOS_FCTR 
	WHERE LOS_FCTR_ID = benELIGLOSEO.LOS_FCTR_ID
	) RES_LENGTH_OF_SERVICE
,DECODE(benELIGLOSEO.EXCLD_FLAG,'Y','Yes','No') RES_EXCLUDE
,TO_CHAR(benELIGLOSEO.START_DATE,'DD-Mon-YYYY') RES_START_DATE
,TO_CHAR(benELIGLOSEO.END_DATE,'DD-Mon-YYYY') RES_END_DATE
,benELIGLOSEO.LAST_UPDATED_BY  RSC_LAST_UPDATED_BY
,benELIGLOSEO.LAST_UPDATE_DATE  RSC_LAST_UPDATE_DATE
,benELIGLOSEO.CREATED_BY  RSC_CREATED_BY
,benELIGLOSEO.CREATION_DATE  RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM BEN_ELIGY_PRFL benELIGYEO
,BEN_ELIG_LOS_PRTE benELIGLOSEO
WHERE SYSDATE BETWEEN benELIGYEO.START_DATE AND NVL(benELIGYEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
AND benELIGYEO.ELIGY_PRFL_ID = benELIGLOSEO.ELIGY_PRFL_ID 
AND benELIGYEO.END_DATE BETWEEN benELIGLOSEO.START_DATE AND NVL(benELIGLOSEO.END_DATE,TO_DATE('4712-12-31','YYYY-MM-DD'))
ORDER BY benELIGYEO.NAME
,benELIGLOSEO.ORDR_NUM