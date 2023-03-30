/* ****************************************************************************
* $Revision: 56739 $:
* $Author: pisan.jariyasettachok $:
* $Date: 2016-07-20 09:09:10 +0700 (Wed, 20 Jul 2016) $:
* $HeadURL: http://svn01.rapidesuite.com:999/svn/a/dev/rapidesuite/controldata/FUSION_11.1.9/trunk/core/reverse_sql/FINANCIALS/Manage%20Fixed%20Assets%20Key%20Flexfields%20-%20Segment%20Instance.sql $:
* $Id: Manage Fixed Assets Key Flexfields - Segment Instance.sql 56739 2016-07-20 02:09:10Z pisan.jariyasettachok $:
* ****************************************************************************
* Description:
* ************************************************************************** */


SELECT InvMaterialStatusesVl.STATUS_CODE RES_NAME
,InvMaterialStatusesVl.DESCRIPTION RES_DESCRIPTION
,DECODE(InvMaterialStatusesVl.ENABLED_FLAG,1,'Yes','No') RES_ACTIVE
,DECODE(InvMaterialStatusesVl.RESERVABLE_TYPE,1,'Yes','No') RES_AVAILABILITY_ALLOW_RESERVA
,DECODE(InvMaterialStatusesVl.INVENTORY_ATP_CODE,1,'Yes','No') RES_AVAILABILITY_INCLUDE_IN_AT
,DECODE(InvMaterialStatusesVl.AVAILABILITY_TYPE,1,'Yes','No') RES_AVAILABILITY_NETTABLE
,DECODE(InvMaterialStatusesVl.ZONE_CONTROL,1,'Yes','No') RES_USAGE_SUBINVENTORY
,DECODE(InvMaterialStatusesVl.LOCATOR_CONTROL,1,'Yes','No') RES_USAGE_LOCATOR
,DECODE(InvMaterialStatusesVl.LOT_CONTROL,1,'Yes','No') RES_USAGE_LOT
,DECODE(InvMaterialStatusesVl.SERIAL_CONTROL,1,'Yes','No') RES_USAGE_SERIAL_NUMBER
,InvMaterialStatusesVl.LAST_UPDATED_BY RSC_LAST_UPDATED_BY
,InvMaterialStatusesVl.LAST_UPDATE_DATE RSC_LAST_UPDATE_DATE
,InvMaterialStatusesVl.CREATED_BY RSC_CREATED_BY
,InvMaterialStatusesVl.CREATION_DATE RSC_CREATION_DATE
,NULL RSC_LEDGER_ID
,NULL RSC_CHART_OF_ACCOUNTS_ID
,NULL RSC_BUSINESS_UNIT_ID
,NULL RSC_LEGAL_ENTITY_ID
,NULL RSC_ORGANIZATION_ID
,NULL RSC_BUSINESS_GROUP_ID
,NULL RSC_ENTERPRISE_ID
,NULL RSC_COUNTRY_ID

FROM INV_MATERIAL_STATUSES_VL InvMaterialStatusesVl
ORDER BY InvMaterialStatusesVl.STATUS_CODE