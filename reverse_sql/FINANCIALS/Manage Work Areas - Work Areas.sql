/* ****************************************************************************
* $Revision: 59117 $:
* $Author: nasrullah.dusenmahamad $:
* $Date: 2016-10-21 11:10:58 +0700 (Fri, 21 Oct 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Key%20Flexfields%20-%20Segment%20Labels.sql $:
* $Id: Manage Key Flexfields - Segment Labels.sql 59117 2016-10-21 04:10:58Z nasrullah.dusenmahamad $:
* ****************************************************************************
* Description:
* ************************************************************************** */

-- RSC_PREREQUISITE_OBJECTS=WIS_WORK_AREAS_VL

SELECT (SELECT ORGANIZATION_CODE 
	FROM INV_ORG_PARAMETERS
	WHERE ORGANIZATION_ID = WisWorkAreasE0.ORGANIZATION_ID
	) RES_ORGANIZATION
,WisWorkAreasE0.WORK_AREA_NAME RES_NAME
,WisWorkAreasE0.WORK_AREA_CODE RES_CODE
,WisWorkAreasE0.WORK_AREA_DESCRIPTION RES_DESCRIPTION
,TO_CHAR(WisWorkAreasE0.INACTIVE_DATE,'DD-Mon-YYYY') RES_INACTIVE_ON
,WisWorkAreasE0.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,WisWorkAreasE0.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,WisWorkAreasE0.CREATED_BY RSC_CREATED_BY
,WisWorkAreasE0.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM WIS_WORK_AREAS_VL WisWorkAreasE0
ORDER BY RES_ORGANIZATION
,WisWorkAreasE0.WORK_AREA_NAME