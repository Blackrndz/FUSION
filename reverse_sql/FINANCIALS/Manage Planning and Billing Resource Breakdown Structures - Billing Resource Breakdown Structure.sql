/* ****************************************************************************
 * $Revision: 61016 $:
 * $Author: nasrullah.dusenmahamad $:
 * $Date: 2017-02-10 11:47:39 +0700 (Fri, 10 Feb 2017) $:
 * $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.13/trunk/core/reverse_sql/FINANCIALS/Manage%20Transaction%20Sources%20-%20Manage%20Transaction%20Sources.sql $:
 * $Id: Manage Transaction Sources - Manage Transaction Sources.sql 61016 2017-02-10 04:47:39Z nasrullah.dusenmahamad $:
 * ****************************************************************************
 * Description:
 * ************************************************************************** */


SELECT resourcesE0.NAME RES_NAME
,resourcesE0.DESCRIPTION RES_DESCRIPTION
,DECODE(resourcesE0.CENTRALLY_CONTROL_FLAG,'Y','Yes','No') RES_ALL_BUSINESS_UNITS
,(SELECT SET_NAME
    FROM FND_SETID_SETS
    WHERE LANGUAGE = USERENV('LANG')
    AND SET_ID = JOB_SET_ID
	 ) RES_JOB_SET
,TO_CHAR(resourcesE0.START_DATE_ACTIVE,'DD-Mon-YYYY') RES_FROM_DATE
,TO_CHAR(resourcesE0.END_DATE_ACTIVE,'DD-Mon-YYYY') RES_TO_DATE
,resourcesE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,resourcesE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,resourcesE0.CREATED_BY RSC_CREATED_BY
,resourcesE0.CREATION_DATE RSC_CREATION_DATE
,null RSC_LEDGER_ID
,null RSC_CHART_OF_ACCOUNTS_ID
,null RSC_BUSINESS_UNIT_ID
,null RSC_LEGAL_ENTITY_ID
,resourcesE0.PROJECT_UNIT_ID RSC_ORGANIZATION_ID
,null RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM PJF_RBS_HEADERS_VL resourcesE0
,PJF_RBS_VERSIONS_B resVersionsE0
WHERE resourcesE0.RBS_TYPE = 'BILLING'
AND resourcesE0.PROJECT_ID IS NULL
AND resourcesE0.RBS_HEADER_ID = resVersionsE0.RBS_HEADER_ID
ORDER BY resourcesE0.NAME